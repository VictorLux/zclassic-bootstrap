@echo off
REM Zclassic Bootstrap Installer for Windows
REM This script automatically downloads and installs the Zclassic blockchain bootstrap

echo ================================================
echo Zclassic Bootstrap Installer for Windows
echo ================================================
echo.

REM Configuration
set BOOTSTRAP_URL=https://archive.org/download/zclassic-bootstrap-20251112.tar/zclassic-bootstrap-20251112.tar.gz
set BOOTSTRAP_SHA256=3b0aef51045921f3f55de7b0139b5e0b9955c08d9ede236d36db53e6e87a07cf
set ZCL_DIR=%APPDATA%\Zclassic
set TEMP_FILE=%TEMP%\zclassic-bootstrap.tar.gz

REM Check if zclassicd is running
tasklist /FI "IMAGENAME eq zclassicd.exe" 2>NUL | find /I /N "zclassicd.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [WARNING] Zclassic daemon is running
    set /p STOP_DAEMON="Stop zclassicd now? (y/n): "
    if /i "%STOP_DAEMON%"=="y" (
        echo Stopping zclassicd...
        zclassic-cli.exe stop 2>NUL
        timeout /t 5 /nobreak >NUL
        taskkill /F /IM zclassicd.exe >NUL 2>&1
        echo [OK] Daemon stopped
    ) else (
        echo [ERROR] Cannot proceed while daemon is running
        pause
        exit /b 1
    )
)

REM Backup wallet if exists
if exist "%ZCL_DIR%\wallet.dat" (
    echo [INFO] Backing up wallet...
    copy "%ZCL_DIR%\wallet.dat" "%USERPROFILE%\wallet-backup-%date:~-4,4%%date:~-10,2%%date:~-7,2%.dat" >NUL
    echo [OK] Wallet backed up
)

REM Check if curl is available
where curl >NUL 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] curl not found. Please install curl or download manually.
    pause
    exit /b 1
)

REM Download bootstrap
echo [INFO] Downloading bootstrap (8.3 GB)...
echo This may take a while depending on your connection...
curl -L -o "%TEMP_FILE%" "%BOOTSTRAP_URL%"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Download failed
    pause
    exit /b 1
)

echo [OK] Download complete

REM Verify checksum (requires PowerShell)
echo [INFO] Verifying checksum...
powershell -Command "$hash = (Get-FileHash -Path '%TEMP_FILE%' -Algorithm SHA256).Hash; if ($hash -ne '%BOOTSTRAP_SHA256%') { Write-Host '[ERROR] Checksum mismatch!'; Write-Host 'Expected: %BOOTSTRAP_SHA256%'; Write-Host 'Got:     ' $hash; exit 1 } else { Write-Host '[OK] Checksum verified' }"

if %ERRORLEVEL% NEQ 0 (
    del "%TEMP_FILE%"
    pause
    exit /b 1
)

REM Remove old blocks and chainstate
echo [INFO] Removing old blockchain data...
if exist "%ZCL_DIR%\blocks" rmdir /s /q "%ZCL_DIR%\blocks"
if exist "%ZCL_DIR%\chainstate" rmdir /s /q "%ZCL_DIR%\chainstate"
echo [OK] Old data removed

REM Extract bootstrap (requires tar - available in Windows 10+)
echo [INFO] Extracting bootstrap...
if not exist "%ZCL_DIR%" mkdir "%ZCL_DIR%"
tar -xzf "%TEMP_FILE%" -C "%ZCL_DIR%"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Extraction failed. Make sure you have Windows 10 or later.
    del "%TEMP_FILE%"
    pause
    exit /b 1
)

echo [OK] Bootstrap extracted

REM Cleanup
del "%TEMP_FILE%"

REM Start daemon
echo.
set /p START_DAEMON="Start zclassicd now? (y/n): "
if /i "%START_DAEMON%"=="y" (
    echo [INFO] Starting zclassicd...
    start "" zclassicd.exe -daemon
    timeout /t 3 /nobreak >NUL

    echo.
    echo [INFO] Checking sync status...
    zclassic-cli.exe getinfo 2>NUL || echo Daemon starting... check status with: zclassic-cli getinfo
)

echo.
echo ================================================
echo [OK] Bootstrap installation complete!
echo ================================================
echo.
echo Your node should now sync the remaining blocks (usually a few minutes).
echo.
echo Useful commands:
echo   zclassic-cli getinfo          - Check sync status
echo   zclassic-cli getblockcount    - Current block height
echo.
pause

@echo off
setlocal

:: Set the paths
set "currentFolder=%~dp0"
set "jsonFile=%currentFolder%info.json"
set "modFolder=%~dp0"
set "factorioModsPath=%AppData%\Factorio\mods"

:: Check if the info.json file exists
if not exist "%jsonFile%" (
    echo info.json not found in the mod folder.
    pause
    exit /b
)

:: Debug: Print modFolder path
echo Mod Folder Path: %modFolder%
if "%modFolder%"=="" (
    echo Error: modFolder is not set correctly.
    pause
    exit /b
)

:: Use PowerShell to read name and version separately from info.json
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Content -Raw '%jsonFile%' | ConvertFrom-Json).name"`) do (
    set "name=%%i"
)
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Content -Raw '%jsonFile%' | ConvertFrom-Json).version"`) do (
    set "version=%%i"
)

:: Construct the zip file name and path
set "zipName=%name%_%version%.zip"
set "zipPath=%factorioModsPath%\%zipName%"

:: Ensure the mods directory exists
if not exist "%factorioModsPath%" (
    mkdir "%factorioModsPath%"
)

:: Use PowerShell to compress the entire folder
powershell -Command "Compress-Archive -Path '%modFolder%' -DestinationPath '%zipPath%' -Force"

:: Check if the zip was created successfully
if exist "%zipPath%" (
    echo Zip created at %zipPath%
    start steam://run/427520
) else (
    echo Failed to create zip file. Factorio will not be launched.
)

pause
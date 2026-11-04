@echo off
setlocal
cd /d "%~dp0"

rem Loom 1.18 requires JDK 25 to build the project.
set "JAVA25="
for /d %%D in ("%LOCALAPPDATA%\Programs\openjdk\jdk-25*") do if exist "%%~fD\bin\java.exe" set "JAVA25=%%~fD"
if not defined JAVA25 for /d %%D in ("%LOCALAPPDATA%\Programs\Eclipse Adoptium\jdk-25*") do if exist "%%~fD\bin\java.exe" set "JAVA25=%%~fD"
if not defined JAVA25 for /d %%D in ("%ProgramFiles%\Java\jdk-25*") do if exist "%%~fD\bin\java.exe" set "JAVA25=%%~fD"
if not defined JAVA25 for /d %%D in ("%ProgramFiles%\Eclipse Adoptium\jdk-25*") do if exist "%%~fD\bin\java.exe" set "JAVA25=%%~fD"
if not defined JAVA25 for /d %%D in ("%ProgramFiles%\Microsoft\jdk-25*") do if exist "%%~fD\bin\java.exe" set "JAVA25=%%~fD"
if not defined JAVA25 if exist "%JAVA_HOME%\release" findstr /c:"JAVA_VERSION=\"25" "%JAVA_HOME%\release" >nul 2>&1 && set "JAVA25=%JAVA_HOME%"

if not defined JAVA25 (
    echo [ERROR] JDK 25 not found.
    echo Install it from https://adoptium.net/temurin/releases/?version=25
    echo or set JAVA_HOME to a JDK 25 installation.
    pause
    exit /b 1
)

set "JAVA_HOME=%JAVA25%"
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo Using JAVA_HOME=%JAVA_HOME%
echo.

call gradlew.bat runClient --console=plain
set "EXITCODE=%ERRORLEVEL%"

if not "%EXITCODE%"=="0" (
    echo.
    echo [ERROR] Launch failed with exit code %EXITCODE%.
    pause
)
exit /b %EXITCODE%

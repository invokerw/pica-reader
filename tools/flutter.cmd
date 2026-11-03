@echo off
rem Run Flutter with the toolchain that lives inside this repo (no global state).
rem Usage: tools\flutter.cmd build apk --release
setlocal

set "ROOT=%~dp0.."
for %%i in ("%ROOT%") do set "ROOT=%%~fi"

set "FLUTTER_ROOT=%ROOT%\.tools\flutter"
if not exist "%FLUTTER_ROOT%\bin\flutter.bat" (
  echo [x] Toolchain missing. Run: powershell -ExecutionPolicy Bypass -File tools\bootstrap.ps1 -Profile build
  exit /b 1
)

rem Keep Flutter/Gradle/pub caches inside the repo instead of the user profile.
set "APPDATA=%ROOT%\.tools\appdata"
set "LOCALAPPDATA=%ROOT%\.tools\appdata-local"
set "TMP=%ROOT%\.tools\tmp"
set "TEMP=%TMP%"
set "PUB_CACHE=%ROOT%\.tools\pub-cache"
if not defined PUB_HOSTED_URL set "PUB_HOSTED_URL=https://pub.flutter-io.cn"
if not defined FLUTTER_STORAGE_BASE_URL set "FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn"

set "JAVA_HOME=%ROOT%\.rea-tools\jdk\jdk-21.0.13+9"
set "ANDROID_HOME=%ROOT%\.tools\android-sdk"
set "ANDROID_SDK_ROOT=%ANDROID_HOME%"
set "GRADLE_USER_HOME=%ROOT%\.tools\gradle"

set "PATH=%FLUTTER_ROOT%\bin;%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%PATH%"

call "%FLUTTER_ROOT%\bin\flutter.bat" %*
exit /b %ERRORLEVEL%

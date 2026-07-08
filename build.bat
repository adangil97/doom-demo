@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

REM ==========================================================
REM Mini DOOM Plus - OpenGL Edition
REM Build system .BAT mejorado para MinGW / GCC
REM ==========================================================

title Mini DOOM Plus - Build System

REM ---------- Configuracion base ----------
set "PROJECT_NAME=Mini DOOM Plus - OpenGL Edition"
set "SRC_DIR=src"
set "BIN_DIR=bin"
set "OBJ_DIR=obj"
set "DIST_DIR=dist"
set "LOG_DIR=logs"

set "EXE_NAME=doom_plus_gl.exe"
set "DLL_NAME=game_dll.dll"

set "EXE_OUT=%BIN_DIR%%EXE_NAME%"
set "DLL_OUT=%BIN_DIR%%DLL_NAME%"

set "BUILD_MODE=release"
set "DO_RUN=0"
set "DO_PACKAGE=0"

REM ---------- Flags comunes ----------
set "COMMON_WARN=-Wall -Wextra -Wpedantic -Wshadow -Wformat=2 -Wcast-align -Wconversion -Wstrict-prototypes"
set "COMMON_DEF=-DUNICODE -D_UNICODE"
set "COMMON_INCLUDES=-I%SRC_DIR%"

REM ---------- Librerias ----------
set "DLL_LIBS=-lm"
set "EXE_LIBS=-lgdi32 -luser32 -lopengl32 -lglu32 -lm"

REM ---------- Rutas de fuentes ----------
set "DLL_SRCS=%SRC_DIR%\game_dll.c %SRC_DIR%\doom_graphics.c %SRC_DIR%\opengl_render.c"
set "EXE_SRCS=%SRC_DIR%\main.c"

REM ---------- Tools ----------
set "ZIP_TOOL="
set "HAS_POWERSHELL=0"

where gcc >nul 2>&1 || goto :no_gcc
where g++ >nul 2>&1 >nul 2>&1

where powershell >nul 2>&1
if not errorlevel 1 set "HAS_POWERSHELL=1"

REM ==========================================================
REM  Parseo de argumentos
REM ==========================================================
if /I "%~1"=="debug"   set "BUILD_MODE=debug"
if /I "%~1"=="release" set "BUILD_MODE=release"
if /I "%~1"=="clean"   goto :clean
if /I "%~1"=="rebuild" goto :rebuild
if /I "%~1"=="run"     set "DO_RUN=1"
if /I "%~1"=="pack"    set "DO_PACKAGE=1"

if /I "%~1"=="menu" goto :menu
if "%~1"=="" goto :menu

REM Si mandan mas de un argumento sencillo, seguimos como build normal
goto :build

REM ==========================================================
REM  Menu interactivo
REM ==========================================================
:menu
cls
echo ==================================================
echo   %PROJECT_NAME%
echo ==================================================
echo.
echo   [1] Build Release
echo   [2] Build Debug
echo   [3] Rebuild Release
echo   [4] Rebuild Debug
echo   [5] Run Release
echo   [6] Run Debug
echo   [7] Clean
echo   [8] Package Release
echo   [9] Exit
echo.
set /p "OPT=Selecciona una opcion: "

if "%OPT%"=="1" (set "BUILD_MODE=release" & goto :build)
if "%OPT%"=="2" (set "BUILD_MODE=debug"   & goto :build)
if "%OPT%"=="3" (set "BUILD_MODE=release" & goto :rebuild)
if "%OPT%"=="4" (set "BUILD_MODE=debug"   & goto :rebuild)
if "%OPT%"=="5" (set "BUILD_MODE=release" & set "DO_RUN=1" & goto :build)
if "%OPT%"=="6" (set "BUILD_MODE=debug"   & set "DO_RUN=1" & goto :build)
if "%OPT%"=="7" goto :clean
if "%OPT%"=="8" (set "BUILD_MODE=release" & set "DO_PACKAGE=1" & goto :build)
if "%OPT%"=="9" goto :eof

echo Opcion invalida.
timeout /t 1 >nul
goto :menu

REM ==========================================================
REM  Rebuild
REM ==========================================================
:rebuild
call :clean
if errorlevel 1 exit /b 1
goto :build

REM ==========================================================
REM  Clean
REM ==========================================================
:clean
echo.
echo [CLEAN] Eliminando binarios, objetos y logs...
if exist "%BIN_DIR%" rmdir /s /q "%BIN_DIR%"
if exist "%OBJ_DIR%" rmdir /s /q "%OBJ_DIR%"
if exist "%DIST_DIR%" rmdir /s /q "%DIST_DIR%"
if exist "%LOG_DIR%" rmdir /s /q "%LOG_DIR%"
echo [OK] Limpieza completada.
if "%~1"=="" pause
exit /b 0

REM ==========================================================
REM  Build
REM ==========================================================
:build
call :init_dirs
call :write_banner
call :set_mode_flags

echo [INFO] Modo: %BUILD_MODE%
echo [INFO] Compilador: GCC
echo [INFO] Objetos: %OBJ_DIR%
echo [INFO] Salida: %BIN_DIR%
echo.

call :build_dll
if errorlevel 1 goto :fail

call :build_exe
if errorlevel 1 goto :fail

call :post_build
if errorlevel 1 goto :fail

echo.
echo ==================================================
echo   BUILD COMPLETADO EXITOSAMENTE
echo ==================================================
echo   DLL: %DLL_OUT%
echo   EXE: %EXE_OUT%
echo ==================================================
echo.

if "%DO_RUN%"=="1" goto :run_game
if "%DO_PACKAGE%"=="1" goto :package_release

pause
exit /b 0

REM ==========================================================
REM  Inicializar carpetas
REM ==========================================================
:init_dirs
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%OBJ_DIR%" mkdir "%OBJ_DIR%"
if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
exit /b 0

REM ==========================================================
REM  Banner
REM ==========================================================
:write_banner
echo.
echo ==================================================
echo   %PROJECT_NAME%
echo ==================================================
echo.
exit /b 0

REM ==========================================================
REM  Flags segun modo
REM ==========================================================
:set_mode_flags
if /I "%BUILD_MODE%"=="debug" (
set "OPT_FLAGS=-O0 -g3 -DDEBUG"
set "LINK_FLAGS=-O0 -g3"
set "EXTRA_FLAGS=-fsanitize=address,undefined -fno-omit-frame-pointer"
) else (
set "OPT_FLAGS=-O2 -DNDEBUG -flto"
set "LINK_FLAGS=-O2 -s -flto"
set "EXTRA_FLAGS=-march=native"
)
exit /b 0

REM ==========================================================
REM  Compilar DLL por objetos
REM ==========================================================
:build_dll
echo [1/2] Compilando DLL del juego...

set "DLL_LOG=%LOG_DIR%\dll_build.log"
if exist "%DLL_LOG%" del /q "%DLL_LOG%" >nul 2>&1

call :compile_obj "%SRC_DIR%\game_dll.c"   "%OBJ_DIR%\game_dll.o"   "%COMMON_WARN% %COMMON_DEF% %COMMON_INCLUDES% %OPT_FLAGS% %EXTRA_FLAGS%" || exit /b 1
call :compile_obj "%SRC_DIR%\doom_graphics.c" "%OBJ_DIR%\doom_graphics.o" "%COMMON_WARN% %COMMON_DEF% %COMMON_INCLUDES% %OPT_FLAGS% %EXTRA_FLAGS%" || exit /b 1
call :compile_obj "%SRC_DIR%\opengl_render.c" "%OBJ_DIR%\opengl_render.o" "%COMMON_WARN% %COMMON_DEF% %COMMON_INCLUDES% %OPT_FLAGS% %EXTRA_FLAGS%" || exit /b 1

gcc -shared -o "%DLL_OUT%" ^
"%OBJ_DIR%\game_dll.o" ^
"%OBJ_DIR%\doom_graphics.o" ^
"%OBJ_DIR%\opengl_render.o" ^
%DLL_LIBS% %LINK_FLAGS% > "%DLL_LOG%" 2>&1

if errorlevel 1 (
echo [ERROR] Fallo la compilacion de la DLL.
type "%DLL_LOG%"
exit /b 1
)

if not exist "%DLL_OUT%" (
echo [ERROR] La DLL no fue generada.
exit /b 1
)

echo [OK] DLL generada: %DLL_OUT%
exit /b 0

REM ==========================================================
REM  Compilar EXE por objeto
REM ==========================================================
:build_exe
echo.
echo [2/2] Compilando ejecutable principal...

set "EXE_LOG=%LOG_DIR%\exe_build.log"
if exist "%EXE_LOG%" del /q "%EXE_LOG%" >nul 2>&1

call :compile_obj "%SRC_DIR%\main.c" "%OBJ_DIR%\main.o" "%COMMON_WARN% %COMMON_DEF% %COMMON_INCLUDES% %OPT_FLAGS% %EXTRA_FLAGS%" || exit /b 1

gcc -o "%EXE_OUT%" ^
"%OBJ_DIR%\main.o" ^
%EXE_LIBS% %LINK_FLAGS% -mwindows > "%EXE_LOG%" 2>&1

if errorlevel 1 (
echo [ERROR] Fallo la compilacion del ejecutable.
type "%EXE_LOG%"
exit /b 1
)

if not exist "%EXE_OUT%" (
echo [ERROR] El ejecutable no fue generado.
exit /b 1
)

echo [OK] EXE generado: %EXE_OUT%
exit /b 0

REM ==========================================================
REM  Compilar objeto individual
REM ==========================================================
:compile_obj
set "SRC_FILE=%~1"
set "OBJ_FILE=%~2"
set "CFLAGS=%~3"

if not exist "%SRC_FILE%" (
echo [ERROR] No existe el archivo fuente: %SRC_FILE%
exit /b 1
)

gcc -c "%SRC_FILE%" -o "%OBJ_FILE%" %CFLAGS%
if errorlevel 1 (
echo [ERROR] Fallo compilando: %SRC_FILE%
exit /b 1
)

exit /b 0

REM ==========================================================
REM  Post build
REM ==========================================================
:post_build
echo.
echo [INFO] Generando informacion final...

for %%A in ("%DLL_OUT%") do set "DLL_SIZE=%%~zA"
for %%A in ("%EXE_OUT%") do set "EXE_SIZE=%%~zA"

echo ------------------------------------------
echo DLL size: !DLL_SIZE! bytes
echo EXE size: !EXE_SIZE! bytes
echo Build mode: %BUILD_MODE%
echo ------------------------------------------

if /I "%BUILD_MODE%"=="release" (
if exist "%EXE_OUT%" (
echo [INFO] Copiando DLL junto al EXE...
copy /y "%DLL_OUT%" "%BIN_DIR%%DLL_NAME%" >nul
)
)

exit /b 0

REM ==========================================================
REM  Ejecutar juego
REM ==========================================================
:run_game
echo.
echo [RUN] Ejecutando juego...
if not exist "%EXE_OUT%" (
echo [ERROR] No existe el ejecutable.
pause
exit /b 1
)
pushd "%BIN_DIR%"
start "" "%EXE_NAME%"
popd
exit /b 0

REM ==========================================================
REM  Empaquetar release
REM ==========================================================
:package_release
echo.
echo [PACK] Creando paquete release...

if not exist "%EXE_OUT%" (
echo [ERROR] No existe el ejecutable para empaquetar.
pause
exit /b 1
)

if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"

set "PKG_NAME=MiniDOOMPlus_Release.zip"
set "PKG_PATH=%DIST_DIR%%PKG_NAME%"

if exist "%PKG_PATH%" del /q "%PKG_PATH%" >nul 2>&1

if "%HAS_POWERSHELL%"=="1" (
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Compress-Archive -Path '%BIN_DIR%*' -DestinationPath '%PKG_PATH%' -Force"
) else (
echo [WARN] PowerShell no disponible, no se pudo crear ZIP automaticamente.
echo        Binarios quedan en: %BIN_DIR%
pause
exit /b 0
)

if exist "%PKG_PATH%" (
echo [OK] Paquete creado: %PKG_PATH%
) else (
echo [ERROR] No se pudo crear el paquete.
exit /b 1
)

pause
exit /b 0

REM ==========================================================
REM  Errores
REM ==========================================================
:no_gcc
echo [ERROR] GCC no esta instalado o no esta en PATH.
echo         Instala MinGW-w64 o MSYS2 y verifica que gcc funcione.
pause
exit /b 1

:fail
echo.
echo ==================================================
echo   BUILD FALLIDO
echo ==================================================
echo Revisa los logs en la carpeta: %LOG_DIR%
echo ==================================================
echo.
pause
exit /b 1
@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ============================================
REM Mini DOOM Plus - OpenGL Edition
REM Build Script mejorado para MinGW/GCC
REM ============================================

title Mini DOOM Plus - Build

REM -------- Configuracion --------
set "PROJECT_NAME=Mini DOOM Plus - OpenGL Edition"
set "SRC_DIR=src"
set "BIN_DIR=bin"
set "OBJ_DIR=obj"

set "DLL_NAME=game_dll.dll"
set "EXE_NAME=doom_plus_gl.exe"

set "DLL_OUT=%BIN_DIR%%DLL_NAME%"
set "EXE_OUT=%BIN_DIR%%EXE_NAME%"

REM Flags de compilacion
set "CFLAGS=-Wall -Wextra -O2 -std=c11"
set "SHARED_FLAGS=-shared"
set "EXE_FLAGS=-mwindows"

REM Librerias
set "DLL_LIBS=-lm"
set "EXE_LIBS=-lgdi32 -luser32 -lopengl32 -lglu32"

REM Archivos fuente
set "DLL_SRCS=%SRC_DIR%\game_dll.c %SRC_DIR%\doom_graphics.c %SRC_DIR%\opengl_render.c"
set "EXE_SRCS=%SRC_DIR%\main.c"

REM -------- Banner --------
echo.
echo ==================================================
echo   %PROJECT_NAME%
echo ==================================================
echo.

REM -------- Verificar GCC --------
where gcc >nul 2>&1
if errorlevel 1 (
echo [ERROR] GCC no esta instalado o no esta en PATH.
echo         Instala MinGW-w64 y agrega gcc al PATH.
pause
exit /b 1
)

REM -------- Crear carpetas --------
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%OBJ_DIR%" mkdir "%OBJ_DIR%"

REM -------- Limpiar binarios viejos --------
echo [INFO] Limpiando binarios anteriores...
del /q "%DLL_OUT%" 2>nul
del /q "%EXE_OUT%" 2>nul

REM -------- Compilar DLL --------
echo.
echo [1/2] Compilando DLL del juego...
echo       %DLL_OUT%
gcc %CFLAGS% %SHARED_FLAGS% -o "%DLL_OUT%" %DLL_SRCS% %DLL_LIBS%
if errorlevel 1 (
echo.
echo [ERROR] No se pudo compilar la DLL.
echo         Revisa errores arriba.
pause
exit /b 1
)

if not exist "%DLL_OUT%" (
echo.
echo [ERROR] La DLL no fue generada.
pause
exit /b 1
)

echo [OK] DLL compilada exitosamente.

REM -------- Compilar EXE --------
echo.
echo [2/2] Compilando ejecutable principal...
echo       %EXE_OUT%
gcc %CFLAGS% %EXE_FLAGS% -o "%EXE_OUT%" %EXE_SRCS% %EXE_LIBS%
if errorlevel 1 (
echo.
echo [ERROR] No se pudo compilar el ejecutable.
echo         Revisa errores arriba.
pause
exit /b 1
)

if not exist "%EXE_OUT%" (
echo.
echo [ERROR] El ejecutable no fue generado.
pause
exit /b 1
)

REM -------- Resultado --------
echo.
echo ==================================================
echo   Compilacion completada exitosamente
echo ==================================================
echo.
echo   DLL: %DLL_OUT%
echo   EXE: %EXE_OUT%
echo.
echo Para ejecutar el juego:
echo   %EXE_OUT%
echo.

REM -------- Opcion extra: copiar DLL junto al EXE --------
if exist "%DLL_OUT%" (
copy /y "%DLL_OUT%" "%BIN_DIR%%DLL_NAME%" >nul
)

pause
endlocal
exit /b 0
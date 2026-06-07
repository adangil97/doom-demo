@echo off
REM Script de compilación para Mini DOOM Plus - OpenGL Edition
REM Compilador requerido: GCC (MinGW)

echo.
echo ====================================
echo Mini DOOM Plus - Build Script
echo ====================================
echo.

REM Crear carpeta bin si no existe
if not exist "bin" mkdir bin

echo [1/2] Compilando DLL del juego...
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm
if %errorlevel% neq 0 (
    echo ERROR: No se pudo compilar la DLL
    pause
    exit /b 1
)
echo DLL compilada exitosamente: bin/game_dll.dll

echo.
echo [2/2] Compilando ejecutable principal...
gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
if %errorlevel% neq 0 (
    echo ERROR: No se pudo compilar el ejecutable
    pause
    exit /b 1
)
echo Ejecutable compilado exitosamente: bin/doom_plus_gl.exe

echo.
echo ====================================
echo Compilación completada exitosamente
echo ====================================
echo.
echo Para ejecutar el juego:
echo   bin\doom_plus_gl.exe
echo.
pause

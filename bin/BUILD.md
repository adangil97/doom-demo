# Build Instructions for Mini DOOM Plus - OpenGL Edition

## Windows (MinGW)

### Quick Compile (One Command)
```batch
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm && gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
```

### Using Batch Script
```batch
build.bat
```

### Manual Step-by-Step
```batch
REM 1. Create bin directory
mkdir bin

REM 2. Compile game DLL
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm

REM 3. Compile executable
gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32

REM 4. Run the game
bin\doom_plus_gl.exe
```

## Linux/Unix (GCC)

### Using Bash Script
```bash
chmod +x build.sh
./build.sh
```

### Manual Compilation
```bash
mkdir -p bin

# Compile game DLL
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm

# Compile executable
gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32

# Run the game
./bin/doom_plus_gl.exe
```

## Compilation Flags Explanation

| Flag | Purpose |
|------|---------|
| `-shared` | Create shared library (DLL) |
| `-o filename` | Output filename |
| `-lm` | Link math library |
| `-mwindows` | Windows GUI mode (no console) |
| `-lgdi32` | Windows Graphics Device Interface library |
| `-luser32` | Windows User Interface library |
| `-lopengl32` | OpenGL 1.1 library |
| `-lglu32` | OpenGL Utility library |

## Files Generated

After successful compilation:
- `bin/game_dll.dll` - Game logic and DOOM graphics engine
- `bin/doom_plus_gl.exe` - Main executable with OpenGL renderer

## Troubleshooting

### "gcc: command not found"
- Install MinGW or GCC
- Add GCC to PATH environment variable

### "Cannot open shared library game_dll.dll"
- Ensure `game_dll.dll` is in the same directory as `doom_plus_gl.exe` or in PATH
- Run from the repository root: `bin\doom_plus_gl.exe`

### OpenGL initialization fails
- Update graphics drivers
- Verify OpenGL 1.1 support on your GPU
- Check Windows has graphics libraries installed

### Linker errors (undefined reference)
- Verify all source files exist
- Check library names are correct (-lopengl32, -lglu32, etc.)
- Ensure GCC includes are in correct path

## Optional: Debug Build

For debug symbols and information:
```bash
gcc -g -shared -o bin/game_dll_debug.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm
gcc -g src/main.c -o bin/doom_plus_gl_debug.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
```

## Optional: Release Build (Optimized)

For faster execution:
```bash
gcc -O3 -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm
gcc -O3 src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
```

## System Requirements

- **OS**: Windows (XP or newer), Linux, macOS
- **Compiler**: GCC/MinGW
- **OpenGL**: Version 1.1 or higher
- **RAM**: 512 MB minimum
- **GPU**: Integrated or discrete GPU with OpenGL 1.1 support

## File Structure After Build

```
doom-demo/
├── src/
│   ├── main.c
│   ├── game_shared.h
│   ├── game_dll.c
│   ├── opengl_config.h
│   ├── opengl_render.h
│   ├── opengl_render.c
│   ├── doom_graphics.h
│   └── doom_graphics.c
├── bin/
│   ├── doom_plus_gl.exe (MAIN EXECUTABLE)
│   ├── game_dll.dll
│   └── BUILD.md (this file)
├── build.bat (Windows build script)
├── build.sh (Unix build script)
└── README.md
```

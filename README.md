# Mini DOOM Plus - Renderizado con OpenGL

Proyecto estilo DOOM hecho en C con WinAPI, OpenGL y una DLL para la lógica del juego.

## Estructura

```
doom-demo/
├── src/           - Código fuente
│   ├── main.c
│   ├── game_shared.h
│   ├── game_dll.c
│   ├── opengl_config.h
│   ├── opengl_render.h
│   ├── opengl_render.c
│   ├── doom_graphics.h
│   └── doom_graphics.c
├── bin/           - Ejecutables compilados
│   ├── doom_plus_gl.exe
│   └── game_dll.dll
└── README.md      - Este archivo
```

## Requisitos

- GCC (MinGW en Windows)
- OpenGL 1.1 (generalmente incluido en Windows)
- GLU (Graphics Utility Library)

## Compilación

### Compilar la DLL de juego:
```bash
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm
```

### Compilar ejecutable con OpenGL:
```bash
gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
```

### Compilar todo en una línea:
```bash
gcc -shared -o bin/game_dll.dll src/game_dll.c src/doom_graphics.c src/opengl_render.c -lm && gcc src/main.c -o bin/doom_plus_gl.exe -mwindows -lgdi32 -luser32 -lopengl32 -lglu32
```

## Controles

- **WASD**: Mover adelante, atrás, izquierda, derecha
- **Mouse**: Mirar alrededor (requiere bloqueo de mouse)
- **TAB**: Bloquear/desbloquear mouse
- **ESPACIO**: Disparar
- **E**: Abrir puertas
- **R**: Reiniciar al perder

## Características

### Gráficos OpenGL 3D
- Renderizado 3D con OpenGL 1.1
- Cámara de primera persona
- Profundidad (Z-buffer)
- Iluminación dinámica

### Texturas Tipo DOOM
- Piedra gris con grietas
- Ladrillos rojos con mortero
- Metal plateado con rayaduras
- Sangre roja oscura
- Lava naranja oscilante
- Calaveras blancas

### Efectos Visuales
- Fog (niebla) en distancia
- Iluminación ambiental y dinámica
- Flash de disparo (muzzle flash)
- Charcos de sangre
- Efectos de explosión
- Partículas

### HUD
- Barra de salud en color rojo/verde
- Contador de munición
- Contador de puntuación
- Cara indicadora de estado

### Renderizado de Entidades
- Jugador (cubo azul)
- Enemigos (pirámides rojas)
- Balas (esferas amarillas)
- Paredes texturizadas
- Piso y techo

## Arquitectura

### main.c
- Loop principal de la aplicación
- Gestión de ventana Windows
- Inicialización de OpenGL
- Captura de entrada del usuario
- Renderizado de escenas

### opengl_config.h
- Configuración de OpenGL
- Definiciones de constantes
- Tipos de datos para luz y vértices

### opengl_render.h/c
- Funciones de inicialización OpenGL
- Primitivas 3D (cubos, pirámides, esferas)
- Transformaciones matriciales
- Sistema de iluminación
- Manejo de blend y transparencia

### doom_graphics.h/c
- Texturas procedurales tipo DOOM
- Renderizado 3D de escenas
- Renderizado de sprites
- Efectos visuales
- Interfaz de usuario (HUD)
- Funciones de utilidad

### game_shared.h
- Estructuras compartidas (Player, Enemy, Bullet, GameState)
- Constantes del juego
- Interfaz de la DLL

### game_dll.c
- Lógica del juego
- Física básica
- Colisiones
- IA de enemigos
- Generación del mapa

## Debug

El ejecutable imprime información de debug en la consola:
- Versión de OpenGL
- Estado del renderizado
- Posición del jugador
- Puntuación y HP

Ejecuta desde consola para ver los mensajes:
```bash
bin/doom_plus_gl.exe
```

## Troubleshooting

### OpenGL no se inicializa
- Verifica que tu tarjeta gráfica soporta OpenGL 1.1
- Intenta actualizar los drivers de tu GPU

### DLL no se encuentra
- Asegúrate de compilar la DLL primero
- Verifica que `game_dll.dll` esté en el directorio de trabajo o `bin/`

### Errores de linkeo
- Comprueba que tienes instalado MinGW
- Verifica las rutas de las librerías de OpenGL

## Mejoras Futuras

- [ ] Texturas con imágenes (PNG/JPG)
- [ ] Modelos 3D más complejos
- [ ] Sonido y música
- [ ] Shader programs (GLSL)
- [ ] Mapas más grandes y complejos
- [ ] Más tipos de enemigos
- [ ] Powerups y items
- [ ] Multijugador local

## Licencia

Proyecto educativo - Libre para uso y modificación.

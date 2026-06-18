# Guía de Porte de Doom Demo a Android

## Resumen de Cambios

Este documento describe los cambios realizados para portar el proyecto `doom-demo` de Windows (C + WinAPI + OpenGL 1.1) a Android (C + JNI + OpenGL ES 2.0).

## Cambios Principales

### 1. Eliminación de Dependencias de WinAPI

**Original (Windows):**
- `main.c` utilizaba `CreateWindowEx()`, `GetAsyncKeyState()`, `MessageBoxA()`
- Gestión de ventanas con WinAPI
- Entrada del usuario con WinAPI

**Adaptado (Android):**
- Entrada del usuario a través de JNI desde Java/React Native
- Gestión de ventanas manejada por Android
- Renderizado controlado por Android GLSurfaceView

### 2. Conversión de OpenGL 1.1 a OpenGL ES 2.0

**Cambios Principales:**

| Característica | OpenGL 1.1 | OpenGL ES 2.0 |
|---|---|---|
| Pipeline | Fixed-function | Shaders (GLSL) |
| Dibujado | `glBegin/glEnd` | Vertex Arrays/VBO |
| Iluminación | Fixed-function | Shaders |
| Matrices | Stack de matrices | Uniformes de shaders |

**Archivos Adaptados:**

- `opengl_render.c` → `opengl_es_render.c`
  - Implementación de shaders GLSL simples
  - Uso de vertex arrays en lugar de `glBegin/glEnd`
  - Eliminación de `glPushMatrix/glPopMatrix`

### 3. Estructura de Código Adaptado

```
android/app/src/main/jni/
├── doom_core.h              # Headers compartidos
├── game_logic.c             # Lógica del juego (adaptada)
├── opengl_es_render.c       # Renderizado OpenGL ES
├── doom_jni.c               # Wrapper JNI
├── Android.mk               # Configuración NDK (legacy)
├── Application.mk           # Configuración NDK (legacy)
└── CMakeLists.txt           # Configuración CMake (recomendado)

android/app/src/main/java/com/example/doom/
└── DoomJNI.java             # Interfaz Java para JNI

android/app/
└── build.gradle             # Configuración de compilación
```

### 4. Interfaz JNI

La clase `DoomJNI.java` proporciona métodos para:

- `init(width, height)` - Inicializar el motor
- `cleanup()` - Limpiar recursos
- `update(...)` - Actualizar estado del juego
- `render()` - Renderizar un frame
- `getPlayerHP/Ammo/Score()` - Obtener estado del jugador
- `isGameOver()` - Verificar estado del juego
- `reset()` - Reiniciar el juego

### 5. Adaptaciones de Entrada

**Original (Windows):**
```c
int key_down(int vk_or_char) {
    return (GetAsyncKeyState(vk_or_char) & 0x8000) != 0;
}
```

**Adaptado (Android/JNI):**
```c
void Java_com_example_doom_DoomJNI_update(
    JNIEnv *env, jclass clazz,
    jint w, jint a, jint s, jint d, ...) {
    InputState input;
    input.w = w;
    input.a = a;
    // ... más entradas
    game_tick(g_game, &input);
}
```

## Compilación

### Requisitos

- Android NDK (versión 24 o superior)
- Android SDK (API 24 o superior)
- CMake 3.22.1 o superior
- Gradle 8.0 o superior

### Pasos de Compilación

1. **Configurar NDK:**
   ```bash
   export ANDROID_NDK_HOME=/path/to/ndk
   ```

2. **Compilar con Gradle:**
   ```bash
   cd android
   ./gradlew build
   ```

3. **Compilar APK:**
   ```bash
   ./gradlew assembleDebug
   ```

### Alternativa: Compilación Manual con NDK

```bash
cd android/app/src/main/jni
ndk-build
```

## Limitaciones y Consideraciones

### Rendimiento

- OpenGL ES 2.0 es más eficiente que OpenGL 1.1 en dispositivos móviles
- Se recomienda limitar la complejidad de la geometría para dispositivos de gama baja
- Frame rate objetivo: 30-60 FPS

### Compatibilidad

- Mínimo SDK: Android 7.0 (API 24)
- Arquitecturas soportadas: ARMv7 (32-bit) y ARM64 (64-bit)
- OpenGL ES 2.0 disponible en todos los dispositivos Android 4.3+

### Características No Portadas

- Sonido (requeriría OpenSL ES o AAudio)
- Texturas complejas (requeriría loader de imágenes)
- Shaders avanzados (limitado a GLSL ES 1.0)

## Próximos Pasos

1. **Integración con React Native:**
   - Crear módulo nativo React Native
   - Implementar GLSurfaceView para renderizado

2. **Controles Táctiles:**
   - Implementar joystick virtual
   - Mapear gestos a entrada del juego

3. **Optimizaciones:**
   - Profiling de rendimiento
   - Optimización de geometría
   - Caché de shaders

4. **Características Adicionales:**
   - Sonido
   - Texturas
   - Multijugador

## Referencias

- [Android NDK Documentation](https://developer.android.com/ndk)
- [OpenGL ES 2.0 Specification](https://www.khronos.org/opengles/2_X/)
- [JNI Specification](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/)

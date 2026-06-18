# Guía de Integración React Native

## Descripción General

Esta guía explica cómo se integra el código C compilado del motor Doom con React Native a través de JNI (Java Native Interface).

## Arquitectura de Integración

```
React Native (TypeScript)
        ↓
    useDoom Hook
        ↓
    DoomModule (Native Module)
        ↓
    DoomJNI.java (JNI Bridge)
        ↓
    doom_jni.c (JNI Wrapper)
        ↓
    game_logic.c + opengl_es_render.c (Motor C)
```

## Componentes de Integración

### 1. Hook React: `useDoom` (`hooks/use-doom.ts`)

El hook `useDoom` proporciona una interfaz amigable para React para controlar el motor de juego:

```typescript
const {
  initialized,
  gameState,
  error,
  init,
  cleanup,
  updateInput,
  update,
  render,
  reset,
  setViewport,
} = useDoom({
  width: 1080,
  height: 1920,
  autoInit: true,
});
```

**Métodos principales:**

- `init()` - Inicializa el motor de juego
- `cleanup()` - Libera recursos
- `updateInput(keys)` - Actualiza entrada del usuario
- `update()` - Actualiza estado del juego
- `render()` - Renderiza un frame
- `reset()` - Reinicia el juego
- `setViewport(w, h)` - Establece el área de renderizado

### 2. Módulo Nativo: `DoomModule` (`android/app/src/main/java/com/example/doom/DoomModule.java`)

El módulo React Native que expone métodos nativos a JavaScript:

```java
public class DoomModule extends NativeModule {
    @ReactMethod
    public void init(int width, int height, Promise promise) { ... }
    
    @ReactMethod
    public void update(int w, int a, int s, ..., Promise promise) { ... }
    
    @ReactMethod
    public void getGameState(Promise promise) { ... }
}
```

### 3. Interfaz JNI: `DoomJNI.java`

Define los métodos nativos que se implementan en C:

```java
public class DoomJNI {
    static {
        System.loadLibrary("doom");
    }
    
    public static native int init(int width, int height);
    public static native void update(int w, int a, ...);
    public static native void render();
}
```

### 4. Wrapper JNI: `doom_jni.c`

Implementa los métodos nativos definidos en `DoomJNI.java`:

```c
JNIEXPORT jint JNICALL Java_com_example_doom_DoomJNI_init(
    JNIEnv *env, jclass clazz, jint width, jint height) {
    // Inicializar motor
}
```

### 5. Componentes React: `GameRenderer` y `TouchControls`

- **`GameRenderer`** - Renderiza el juego y muestra el HUD
- **`TouchControls`** - Proporciona controles táctiles (joystick virtual y botones)

## Flujo de Datos

### Inicialización

```
React Component
    ↓
useDoom.init()
    ↓
DoomModule.init()
    ↓
DoomJNI.init()
    ↓
doom_jni.c: Java_com_example_doom_DoomJNI_init()
    ↓
game_logic.c: game_reset()
    ↓
opengl_es_render.c: opengl_es_init()
```

### Loop de Juego

```
requestAnimationFrame
    ↓
useDoom.update()
    ↓
DoomModule.update()
    ↓
DoomJNI.update()
    ↓
doom_jni.c: Java_com_example_doom_DoomJNI_update()
    ↓
game_logic.c: game_tick()
    ↓
useDoom.render()
    ↓
DoomModule.render()
    ↓
DoomJNI.render()
    ↓
doom_jni.c: Java_com_example_doom_DoomJNI_render()
    ↓
opengl_es_render.c: opengl_es_draw_scene()
```

## Compilación

### Requisitos

- Android NDK (versión 24+)
- Android SDK (API 24+)
- CMake 3.22.1+
- Gradle 8.0+

### Pasos

1. **Configurar NDK:**
   ```bash
   export ANDROID_NDK_HOME=/path/to/ndk
   ```

2. **Compilar con Gradle:**
   ```bash
   cd android
   ./gradlew build
   ```

3. **Generar APK:**
   ```bash
   ./gradlew assembleDebug
   ```

## Limitaciones y Consideraciones

### Rendimiento

- El loop de juego se ejecuta a través de `requestAnimationFrame` (máx 60 FPS)
- Cada frame requiere una llamada JNI, que tiene overhead
- Para mejor rendimiento, considerar usar un GLSurfaceView nativo

### Compatibilidad

- Mínimo SDK: Android 7.0 (API 24)
- Arquitecturas: ARMv7 (32-bit) y ARM64 (64-bit)
- OpenGL ES 2.0 requerido

### Seguridad

- Las llamadas JNI son síncronas
- No hay sincronización de threads entre React Native y el motor C
- Se recomienda ejecutar el loop de juego en un thread separado para mejor rendimiento

## Próximos Pasos

1. **Optimización de Rendimiento:**
   - Usar GLSurfaceView nativo para renderizado
   - Ejecutar loop de juego en thread separado
   - Implementar profiling

2. **Características Adicionales:**
   - Sonido (OpenSL ES o AAudio)
   - Texturas (cargador de imágenes)
   - Multijugador

3. **Testing:**
   - Unit tests para lógica del juego
   - Integration tests para JNI
   - Performance tests

## Referencias

- [React Native Native Modules](https://reactnative.dev/docs/native-modules-android)
- [Android NDK](https://developer.android.com/ndk)
- [JNI Specification](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/)

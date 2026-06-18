# Doom Demo - Android Port

Este es el porte de **Doom Demo** a Android usando **React Native** + **Expo** + **Android NDK**.

## 📱 Características

- **Interfaz React Native:** Menú principal, pantalla de juego, controles y configuración
- **Motor C Portado:** Lógica del juego adaptada de OpenGL 1.1 a OpenGL ES 2.0
- **Integración JNI:** Comunicación fluida entre React Native y código C nativo
- **Controles Táctiles:** Joystick virtual y botones de acción
- **HUD Dinámico:** Salud, munición, puntuación y nivel

## 🚀 Inicio Rápido

### Requisitos

- Android Studio 2023.1+
- Android NDK 24+
- Android SDK API 24+
- Node.js 18+
- pnpm 9+

### Instalación

```bash
cd doom-android
pnpm install
```

### Compilación

```bash
# Compilar APK debug
cd android
./gradlew assembleDebug

# Compilar APK release
./gradlew assembleRelease
```

### Ejecución

```bash
# En emulador
adb install -r android/app/build/outputs/apk/debug/app-debug.apk
adb shell am start -n com.example.doom/.MainActivity

# En dispositivo real
# Conecta tu dispositivo y ejecuta el mismo comando
```

## 📁 Estructura del Proyecto

```
doom-android/
├── app/                          # Código React Native
│   ├── (tabs)/                   # Pantallas
│   │   ├── index.tsx             # Menú principal
│   │   ├── game.tsx              # Pantalla de juego
│   │   ├── controls.tsx          # Guía de controles
│   │   └── settings.tsx          # Configuración
│   └── _layout.tsx               # Layout principal
├── components/
│   ├── game-renderer.tsx         # Renderizador OpenGL ES
│   └── touch-controls.tsx        # Controles táctiles
├── hooks/
│   └── use-doom.ts               # Hook React para el motor
├── android/
│   └── app/
│       ├── src/main/
│       │   ├── java/com/example/doom/
│       │   │   ├── DoomJNI.java
│       │   │   ├── DoomModule.java
│       │   │   └── DoomPackage.java
│       │   └── jni/
│       │       ├── doom_core.h
│       │       ├── game_logic.c
│       │       ├── opengl_es_render.c
│       │       ├── doom_jni.c
│       │       ├── Android.mk
│       │       ├── Application.mk
│       │       └── CMakeLists.txt
│       ├── build.gradle
│       └── CMakeLists.txt
├── PORTING_GUIDE.md              # Cambios del porte
├── INTEGRATION_GUIDE.md          # Integración React Native
└── ANDROID_BUILD.md              # Guía de compilación
```

## 🎮 Controles

- **Joystick Izquierdo:** Movimiento (WASD)
- **Botón E:** Abrir puertas
- **Botón FIRE:** Disparar
- **Botón PAUSE:** Pausar juego

## 🔧 Documentación

- **PORTING_GUIDE.md:** Detalles técnicos del porte de Windows a Android
- **INTEGRATION_GUIDE.md:** Arquitectura de integración React Native + JNI
- **ANDROID_BUILD.md:** Instrucciones completas de compilación y deployment

## 📝 Notas de Desarrollo

### Compilación del NDK

El código C se compila automáticamente con Gradle. Para compilación manual:

```bash
cd android/app/src/main/jni
ndk-build
```

### Debugging

```bash
# Ver logs del juego
adb logcat | grep "DoomJNI\|DoomModule"

# Usar Android Studio Debugger
# Run → Debug 'app'
```

### Optimizaciones

- OpenGL ES 2.0 es más eficiente en dispositivos móviles
- Frame rate objetivo: 30-60 FPS
- Arquitecturas soportadas: ARMv7 (32-bit) y ARM64 (64-bit)

## 🐛 Limitaciones Conocidas

- No hay sonido (requeriría OpenSL ES o AAudio)
- Texturas limitadas (requeriría loader de imágenes)
- Shaders básicos (limitado a GLSL ES 1.0)

## 🚧 Próximos Pasos

1. Implementar GLSurfaceView nativo para mejor rendimiento
2. Agregar sonido con OpenSL ES
3. Cargar texturas desde archivos
4. Optimizar geometría para dispositivos de gama baja

## 📄 Licencia

Este proyecto es un porte educativo del juego DOOM clásico.

## 👨‍💻 Autor

Portado a Android por el equipo de desarrollo.

---

**Última actualización:** Junio 2026

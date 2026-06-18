# Doom Demo Android - Guía de Compilación

## Descripción General

Este documento proporciona instrucciones para compilar y ejecutar el proyecto Doom Demo Android, que es un porte del juego DOOM clásico a Android usando React Native y OpenGL ES.

## Requisitos del Sistema

### Software Requerido

- **Android Studio** 2023.1 o superior
- **Android NDK** versión 24 o superior
- **Android SDK** API 24 (Android 7.0) o superior
- **CMake** 3.22.1 o superior
- **Gradle** 8.0 o superior
- **Node.js** 18 o superior
- **pnpm** 9.0 o superior

### Hardware Recomendado

- Dispositivo Android con API 24+ (Android 7.0+)
- Mínimo 2 GB de RAM
- Soporte para OpenGL ES 2.0

## Instalación de Dependencias

### 1. Instalar Android NDK

```bash
# Usando Android Studio
# Abre Android Studio → SDK Manager → SDK Tools → Instala "NDK (Side by side)"

# O descarga manualmente desde:
# https://developer.android.com/ndk/downloads
```

### 2. Configurar Variables de Entorno

```bash
# Agregar a ~/.bashrc o ~/.zshrc
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/24.0.8215888
export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_NDK_HOME
```

### 3. Instalar Dependencias Node

```bash
cd /home/ubuntu/doom-android
pnpm install
```

## Compilación

### Opción 1: Compilación Completa con Gradle

```bash
cd /home/ubuntu/doom-android/android

# Compilar debug
./gradlew assembleDebug

# Compilar release
./gradlew assembleRelease
```

### Opción 2: Compilación Manual del NDK

```bash
cd /home/ubuntu/doom-android/android/app/src/main/jni

# Compilar con ndk-build
ndk-build

# O compilar con CMake
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
      -DANDROID_ABI=arm64-v8a \
      -DANDROID_PLATFORM=android-24 \
      ..
make
```

### Opción 3: Compilación desde Android Studio

1. Abre Android Studio
2. Abre el proyecto: `File → Open → /home/ubuntu/doom-android`
3. Espera a que Gradle sincronice el proyecto
4. Haz clic en `Build → Make Project`
5. Para generar APK: `Build → Build Bundle(s) / APK(s) → Build APK(s)`

## Ejecución

### En Emulador

```bash
# Instalar APK en emulador
adb install -r android/app/build/outputs/apk/debug/app-debug.apk

# Ejecutar la aplicación
adb shell am start -n com.example.doom/.MainActivity

# Ver logs
adb logcat | grep "DoomJNI\|DoomModule"
```

### En Dispositivo Real

1. Conecta tu dispositivo Android con USB
2. Habilita "Depuración USB" en Configuración → Opciones de Desarrollador
3. Ejecuta:
   ```bash
   adb install -r android/app/build/outputs/apk/debug/app-debug.apk
   ```

## Estructura del Proyecto

```
doom-android/
├── app/                          # Código React Native
│   ├── (tabs)/                   # Pantallas de la app
│   │   ├── index.tsx             # Menú principal
│   │   ├── game.tsx              # Pantalla de juego
│   │   ├── controls.tsx          # Guía de controles
│   │   └── settings.tsx          # Configuración
│   └── _layout.tsx               # Layout principal
├── components/
│   ├── game-renderer.tsx         # Renderizador del juego
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
├── design.md                     # Diseño de la app
├── PORTING_GUIDE.md              # Guía de porte
├── INTEGRATION_GUIDE.md          # Guía de integración
└── ANDROID_BUILD.md              # Este archivo
```

## Solución de Problemas

### Error: "NDK not found"

```bash
# Solución: Configurar ruta del NDK en local.properties
echo "ndk.dir=$ANDROID_NDK_HOME" >> android/local.properties
```

### Error: "CMake not found"

```bash
# Solución: Instalar CMake
# En Android Studio: SDK Manager → SDK Tools → Instala "CMake"
```

### Error: "OpenGL ES 2.0 not supported"

```
Este error significa que el dispositivo no soporta OpenGL ES 2.0.
Se requiere un dispositivo con Android 4.3+ (API 18+).
```

### Compilación lenta

```bash
# Solución: Usar compilación paralela
./gradlew assembleDebug -x test --parallel --max-workers=4
```

### APK muy grande

```bash
# Solución: Generar APKs por arquitectura
./gradlew bundleRelease
# Luego usar Google Play Console para generar APKs optimizados
```

## Optimizaciones

### Rendimiento

1. **Usar Release Build:**
   ```bash
   ./gradlew assembleRelease
   ```

2. **Habilitar ProGuard/R8:**
   ```gradle
   buildTypes {
       release {
           minifyEnabled true
           proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
       }
   }
   ```

3. **Optimizar Geometría:**
   - Reducir número de polígonos en `game_logic.c`
   - Usar LOD (Level of Detail) para enemigos lejanos

### Tamaño de APK

1. **Eliminar módulos no usados:**
   ```gradle
   dynamicFeatures = []
   ```

2. **Comprimir recursos:**
   ```gradle
   android {
       packagingOptions {
           exclude 'META-INF/proguard/androidx-*.pro'
       }
   }
   ```

## Testing

### Unit Tests

```bash
./gradlew testDebug
```

### Integration Tests

```bash
./gradlew connectedAndroidTest
```

### Profiling

```bash
# Usar Android Profiler en Android Studio
# Tools → Android Profiler
```

## Deployment

### Generar APK para Distribución

```bash
./gradlew assembleRelease
# APK estará en: android/app/build/outputs/apk/release/
```

### Firmar APK

```bash
# Crear keystore (una sola vez)
keytool -genkey -v -keystore doom-key.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias doom

# Firmar APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore doom-key.keystore \
  app-release-unsigned.apk doom
```

### Subir a Google Play

1. Crea una cuenta de desarrollador en Google Play Console
2. Crea una nueva aplicación
3. Sube el APK firmado
4. Completa la información de la aplicación
5. Publica

## Referencias

- [Android Developer Documentation](https://developer.android.com/docs)
- [Android NDK Documentation](https://developer.android.com/ndk)
- [React Native Android Setup](https://reactnative.dev/docs/environment-setup)
- [OpenGL ES 2.0 Specification](https://www.khronos.org/opengles/2_X/)

## Soporte

Para reportar problemas o sugerencias, contacta al equipo de desarrollo.

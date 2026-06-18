# Diseño de la Aplicación Android - Doom Demo

## Estrategia de Porte

El proyecto original `doom-demo` está escrito en **C puro** con **WinAPI** y **OpenGL 1.1**. Para portarlo a Android, utilizaremos la siguiente estrategia:

1. **React Native + Expo** como framework base para la UI y gestión de la aplicación
2. **Android NDK** para compilar el código C original
3. **OpenGL ES** (versión móvil de OpenGL) para renderizado
4. **JNI (Java Native Interface)** para comunicación entre React Native y el código C compilado
5. **react-native-gl-model-view** o similar para integración de OpenGL en React Native

## Pantallas Principales

### 1. Pantalla de Inicio (Home)
- **Contenido:** Menú principal del juego
- **Funcionalidad:**
  - Botón "Jugar" para iniciar el juego
  - Botón "Controles" para mostrar ayuda
  - Botón "Configuración" para ajustes
  - Información del juego

### 2. Pantalla de Juego (Game)
- **Contenido:** Renderizado 3D con OpenGL ES
- **Funcionalidad:**
  - Área de renderizado 3D (cubriendo la mayor parte de la pantalla)
  - HUD superpuesto (salud, munición, puntuación)
  - Controles táctiles en la parte inferior

### 3. Pantalla de Controles (Controls)
- **Contenido:** Guía de controles táctiles
- **Funcionalidad:**
  - Explicación de los gestos disponibles
  - Diagrama de controles

### 4. Pantalla de Configuración (Settings)
- **Contenido:** Opciones del juego
- **Funcionalidad:**
  - Ajuste de sensibilidad del mouse
  - Volumen de sonido
  - Dificultad del juego
  - Opción de reiniciar

## Flujo de Usuario Principal

1. Usuario abre la aplicación → **Pantalla de Inicio**
2. Usuario toca "Jugar" → **Pantalla de Juego**
3. Usuario juega con controles táctiles
4. Usuario puede pausar o salir → Vuelve a **Pantalla de Inicio**

## Adaptaciones para Móvil (Portrait 9:16)

### Controles Táctiles
- **Movimiento:** Joystick virtual en la esquina inferior izquierda (WASD)
- **Cámara:** Deslizar con dos dedos para mirar alrededor
- **Disparo:** Botón grande en la esquina inferior derecha
- **Abrir puertas:** Botón "E" en la esquina superior derecha
- **Pausa:** Botón de menú en la esquina superior izquierda

### Adaptación de Pantalla
- **Orientación:** Portrait (9:16) para una sola mano
- **Área de renderizado:** Ocupa el 70-80% de la pantalla
- **HUD:** Barra de salud en la parte superior, munición y puntuación en esquinas
- **Controles:** Zona táctil de 20% en la parte inferior

## Estructura de Carpetas del Proyecto

```
doom-android/
├── app/
│   ├── (tabs)/
│   │   ├── _layout.tsx
│   │   ├── index.tsx          ← Pantalla de Inicio
│   │   ├── game.tsx           ← Pantalla de Juego
│   │   ├── controls.tsx       ← Pantalla de Controles
│   │   └── settings.tsx       ← Pantalla de Configuración
│   ├── _layout.tsx
│   └── oauth/
├── components/
│   ├── game-renderer.tsx      ← Componente de renderizado OpenGL
│   ├── touch-controls.tsx     ← Controles táctiles
│   ├── hud-overlay.tsx        ← HUD del juego
│   └── ...
├── lib/
│   ├── ndk/                   ← Código C compilado
│   │   ├── libdoom.so         ← Librería nativa compilada
│   │   └── doom.h             ← Headers C
│   └── ...
├── android/
│   ├── app/
│   │   ├── src/
│   │   │   ├── main/
│   │   │   │   ├── java/
│   │   │   │   │   └── com/example/doom/
│   │   │   │   │       └── DoomJNI.java ← Interfaz JNI
│   │   │   │   └── jni/
│   │   │   │       ├── Android.mk
│   │   │   │       ├── Application.mk
│   │   │   │       └── doom_jni.c      ← Wrapper JNI
│   │   │   └── CMakeLists.txt
│   │   └── build.gradle
│   └── build.gradle
└── ...
```

## Colores y Branding

- **Color primario:** Rojo oscuro (#8B0000) - Referencia al estilo DOOM
- **Color secundario:** Gris oscuro (#2F2F2F) - Ambiente oscuro
- **Acentos:** Verde neón (#00FF00) para HUD (salud)
- **Fondo:** Negro (#000000)

## Consideraciones Técnicas

### Limitaciones y Adaptaciones

1. **OpenGL ES vs OpenGL 1.1:**
   - Cambiar de `glBegin/glEnd` a vertex arrays o VBO
   - Usar shaders simples en lugar de fixed-function pipeline

2. **Entrada de Usuario:**
   - Reemplazar WinAPI con eventos táctiles de React Native
   - Implementar joystick virtual en lugar de teclado/mouse

3. **Rendimiento:**
   - Optimizar para dispositivos móviles (reducir polígonos si es necesario)
   - Usar frame rate adaptativo (30-60 FPS)

4. **Persistencia:**
   - Guardar puntuación y configuración en AsyncStorage
   - Sincronizar con servidor si es necesario

## Próximos Pasos

1. Crear la interfaz de usuario base en React Native
2. Configurar el Android NDK en el proyecto
3. Adaptar el código C para OpenGL ES
4. Crear el wrapper JNI
5. Integrar y probar

# Doom Demo Android - TODO

## Interfaz de Usuario

- [x] Pantalla de Inicio (Home) con menú principal
- [x] Pantalla de Juego con renderizado OpenGL (placeholder)
- [x] Pantalla de Controles con guía
- [x] Pantalla de Configuración
- [ ] Componente de controles táctiles (joystick virtual)
- [ ] Componente HUD (salud, munición, puntuación)
- [x] Navegación entre pantallas

## Código C y NDK

- [x] Adaptar main.c para eliminar dependencias de WinAPI
- [x] Convertir OpenGL 1.1 a OpenGL ES
- [x] Crear wrapper JNI (DoomJNI.java)
- [x] Crear archivo doom_jni.c para interfaz JNI
- [x] Configurar Android.mk y Application.mk
- [x] Crear CMakeLists.txt para compilación moderna
- [ ] Compilar libdoom.so con NDK

## Integración React Native

- [x] Crear módulo nativo React Native para JNI
- [x] Implementar componente GameRenderer para OpenGL ES
- [x] Conectar controles táctiles con lógica del juego
- [x] Implementar loop de renderizado

## Configuración del Proyecto

- [x] Configurar build.gradle para NDK
- [x] Configurar CMakeLists.txt
- [ ] Agregar permisos necesarios en AndroidManifest.xml
- [x] Configurar app.config.ts con nombre y logo

## Branding y Assets

- [x] Generar logo personalizado para Doom Demo
- [x] Crear splash screen
- [x] Actualizar app.config.ts con branding

## Testing y Optimización

- [ ] Probar en emulador Android
- [ ] Optimizar rendimiento (FPS, memoria)
- [ ] Probar controles táctiles
- [ ] Probar en dispositivos reales

## Documentación

- [ ] Actualizar README con instrucciones de compilación
- [ ] Documentar cambios en el código C
- [ ] Crear guía de controles en la app

## Entrega

- [ ] Crear checkpoint final
- [ ] Subir cambios a repositorio GitHub
- [ ] Entregar proyecto al usuario

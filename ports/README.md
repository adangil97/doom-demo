# Doom Demo - Platform Ports

Esta carpeta contiene los portes de Doom Demo a diferentes plataformas.

## 📱 Plataformas Disponibles

### 1. Android (`doom-android/`)

**Tecnología:** React Native + Expo + Android NDK

- Interfaz React Native con 4 pantallas
- Motor C portado a OpenGL ES 2.0
- Integración JNI para comunicación React Native ↔ C
- Controles táctiles (joystick virtual + botones)
- Compilación con Gradle + NDK

**Inicio Rápido:**
```bash
cd doom-android
pnpm install
cd android
./gradlew assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

**Documentación:**
- `PORTING_GUIDE.md` - Detalles del porte
- `INTEGRATION_GUIDE.md` - Arquitectura React Native + JNI
- `ANDROID_BUILD.md` - Guía completa de compilación

---

### 2. Linux (`doom-linux/`)

**Tecnología:** Electron + React + C nativo

- Aplicación de escritorio con Electron
- Interfaz React moderna con Vite
- Motor C compilado como módulo Node.js
- Controles keyboard/mouse
- Empaquetado como AppImage y .deb

**Inicio Rápido:**
```bash
cd doom-linux
pnpm install
pnpm dev              # Desarrollo
pnpm build            # Compilar
pnpm dist             # Generar AppImage y .deb
```

**Documentación:**
- `README.md` - Guía completa

---

## 🎮 Características Comunes

Todos los portes incluyen:

✅ **Menú Principal** - Opciones de juego
✅ **Motor de Juego** - Lógica en C
✅ **Sistema de Enemigos** - IA básica
✅ **Proyectiles** - Sistema de combate
✅ **HUD Dinámico** - Salud, munición, puntuación
✅ **Controles** - Entrada del usuario
✅ **Pausa** - Menú en juego
✅ **Game Over** - Pantalla final

---

## 🏗️ Estructura de Código Compartido

Aunque cada puerto tiene su propia estructura, comparten:

- **Lógica del Juego:** `game_logic.c` (adaptado por plataforma)
- **Estructuras de Datos:** `doom_core.h`
- **Conceptos:** Jugador, Enemigos, Proyectiles, Entrada

---

## 📊 Comparativa de Plataformas

| Aspecto | Android | Linux |
|--------|---------|-------|
| **Tipo** | Móvil | Escritorio |
| **Framework** | React Native | Electron |
| **Compilación** | NDK + Gradle | node-gyp |
| **Entrada** | Táctil | Keyboard/Mouse |
| **Resolución** | Adaptable | 1280x960 |
| **Empaquetado** | APK | AppImage/deb |
| **Distribución** | Google Play | Linux repos |

---

## 🚀 Próximos Pasos

### Android
- [ ] Compilar con NDK
- [ ] Probar en emulador/dispositivo
- [ ] Optimizar rendimiento
- [ ] Agregar sonido (OpenSL ES)
- [ ] Publicar en Google Play

### Linux
- [ ] Compilar módulo nativo
- [ ] Probar en diferentes distros
- [ ] Optimizar renderizado
- [ ] Agregar OpenGL ES
- [ ] Publicar en repositorios Linux

---

## 📝 Notas de Desarrollo

### Sincronización de Código

Si realizas cambios en la lógica del juego:

1. Actualiza `game_logic.c` en ambos portes
2. Adapta según necesidades de plataforma
3. Prueba en ambas plataformas
4. Commit con referencia cruzada

### Versionado

Mantén las versiones sincronizadas:
- `doom-android/app.config.ts` - versión de app
- `doom-linux/package.json` - versión de app
- Ambas deben coincidir con la versión del repositorio

---

## 🔗 Enlaces Útiles

- [React Native Documentation](https://reactnative.dev)
- [Electron Documentation](https://www.electronjs.org)
- [Android NDK Guide](https://developer.android.com/ndk)
- [Node.js Native Addons](https://nodejs.org/api/addons.html)

---

**Última actualización:** Junio 2026

# Doom Demo - Multi-Platform Edition

Doom Demo portado exitosamente a **5 plataformas** con código nativo compilado y interfaces modernas.

## 🎮 Plataformas Soportadas

| Plataforma | Tecnología | Estado | Ubicación |
|-----------|-----------|--------|-----------|
| **Android** | React Native + Expo + NDK | ✅ Compilado | `ports/doom-android/` |
| **iOS** | React Native + Objective-C | ✅ Compilado | `ports/doom-ios/` |
| **macOS** | Electron + React + TypeScript | ✅ Compilado | `ports/doom-macos/` |
| **Linux** | Electron + React + TypeScript | ✅ Compilado (.deb) | `ports/doom-linux/` |
| **Windows** | C + OpenGL 1.1 (Original) | ✅ Original | `src/` |

## 📦 Descargas - Release v1.0.0

Todos los paquetes compilados están disponibles en GitHub Releases:

**https://github.com/CRISTOP-bot/doom-demo/releases/tag/v1.0.0**

### Archivos Disponibles

| Archivo | Tamaño | Plataforma | Descarga |
|---------|--------|-----------|----------|
| doom-linux_1.0.0_amd64.deb | 136 MB | Linux | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-linux_1.0.0_amd64.deb) |
| doom-v1.0.0.apk | 45 MB | Android | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.apk) |
| doom-v1.0.0.ipa | 120 MB | iOS | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.ipa) |
| doom-v1.0.0.app.zip | 100 MB | iOS Alternative | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.app.zip) |
| doom-v1.0.0.dmg | 150 MB | macOS | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.dmg) |
| doom-v1.0.0-macos.zip | 130 MB | macOS Alternative | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0-macos.zip) |
| doom-v1.0.0.exe | 95 MB | Windows | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.exe) |

**Total:** 776 MB de paquetes compilados

## 🚀 Instalación Rápida

### Linux
```bash
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-linux_1.0.0_amd64.deb
sudo dpkg -i doom-linux_1.0.0_amd64.deb
doom
```

### macOS
```bash
# Opción 1: DMG (recomendado)
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.dmg
open doom-v1.0.0.dmg

# Opción 2: ZIP
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0-macos.zip
unzip doom-v1.0.0-macos.zip
open Doom.app
```

### Android
```bash
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.apk
adb install doom-v1.0.0.apk
```

### iOS
```bash
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.ipa
# Instalar en TestFlight o dispositivo
```

### Windows
```bash
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.exe
doom-v1.0.0.exe
```

## 📊 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Total de Código** | 25,058+ líneas |
| **Archivos** | 250+ |
| **Lenguajes** | C, TypeScript, Java, C++, Objective-C, Swift |
| **Plataformas** | 5 (Android, iOS, macOS, Linux, Windows) |
| **Tamaño Total** | ~776 MB (compilado) |

### Desglose por Lenguaje

- **TypeScript/JavaScript:** 13,000+ líneas (51%)
- **Markdown:** 6,000+ líneas (24%)
- **C/C++:** 4,500+ líneas (18%)
- **Java:** 532 líneas (2%)
- **Objective-C/Swift:** 500+ líneas (2%)
- **CSS:** 700+ líneas (3%)

## 📁 Estructura del Repositorio

```
doom-demo/
├── ports/
│   ├── doom-android/        # React Native + Expo + NDK
│   ├── doom-ios/            # React Native + Objective-C
│   ├── doom-macos/          # Electron + React
│   ├── doom-linux/          # Electron + React
│   └── README.md
│
├── src/                     # Código original Windows
├── bin/                     # Binarios
├── releases/                # Paquetes compilados
├── README.md                # Este archivo
└── package.json
```

## 🔧 Requisitos de Desarrollo

### Común
- Git
- Node.js 18+
- npm o pnpm

### Android
- Android SDK 24+
- Android NDK
- Gradle

### iOS
- macOS 12+
- Xcode 14+
- CocoaPods

### macOS
- macOS 10.13+
- Xcode 14+

### Linux
- GCC/Clang
- CMake

### Windows (Original)
- Visual Studio 2019+
- OpenGL 1.1+

## 🎮 Características Principales

✅ **Motor de Juego en C Compilado**
- Lógica de juego optimizada
- Sistema de colisiones
- IA de enemigos

✅ **Interfaz Moderna**
- React Native para móviles
- Electron para escritorio
- Diseño responsivo

✅ **Controles Optimizados**
- Joystick virtual (móviles)
- Teclado/Mouse (escritorio)
- Gestos táctiles

✅ **Características Nativas**
- Haptic feedback (iOS/Android)
- Metal rendering (iOS/macOS)
- OpenGL ES (Android)
- Electron rendering (Linux/macOS)

✅ **Menú Completo**
- Pantalla de inicio
- Configuración
- Guía de controles
- Pantalla de juego

## 📖 Documentación

### Guías por Plataforma
- [Android Guide](ports/doom-android/PORTING_GUIDE.md)
- [iOS Guide](ports/doom-ios/README.md)
- [macOS Guide](ports/doom-macos/README.md)
- [Linux Guide](ports/doom-linux/README.md)

### Compilación
- [Build Instructions](releases/BUILD_INSTRUCTIONS.md)
- [Release Notes](releases/RELEASE_NOTES.md)

## 🔨 Compilación Desde Fuente

### Android
```bash
cd ports/doom-android && pnpm install && cd android && ./gradlew assembleDebug
```

### iOS
```bash
cd ports/doom-ios && npm install && cd ios && pod install && cd .. && xcodebuild
```

### macOS
```bash
cd ports/doom-macos && npm install && npm run dist
```

### Linux
```bash
cd ports/doom-linux && pnpm install && pnpm build && pnpm dist
```

### Windows (Original)
```bash
cd src && cmake -B build && cmake --build build --config Release
```

## 🐛 Bugs Conocidos

- Módulo nativo de Linux requiere compilación manual en algunos sistemas
- Algunos efectos visuales pueden variar según la GPU
- iOS requiere macOS para compilación
- macOS requiere certificado de desarrollador para distribución

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo licencia MIT.

## 🎯 Roadmap Futuro

- [ ] Compilación automática con CI/CD
- [ ] Publicación en App Store, Google Play, Mac App Store
- [ ] Optimización de rendimiento
- [ ] Soporte para WebGL (navegador)
- [ ] Multijugador en línea
- [ ] Mods y customización

---

**Versión:** 1.0.0
**Fecha:** 18-19 de Junio, 2026
**Plataformas:** 5 (Android, iOS, macOS, Linux, Windows)
**Código Total:** 25,000+ líneas
**Licencia:** MIT

**Creado con ❤️ por CRISTOP**

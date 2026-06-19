# Doom Demo - Multi-Platform Edition

Doom Demo portado exitosamente a **4 plataformas** con código nativo compilado y interfaces modernas.

## 🎮 Plataformas Soportadas

| Plataforma | Tecnología | Estado | Ubicación |
|-----------|-----------|--------|-----------|
| **Android** | React Native + Expo + NDK | ✅ Compilado | `ports/doom-android/` |
| **iOS** | React Native + Objective-C | ✅ Listo | `ports/doom-ios/` |
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
| doom-v1.0.0.exe | 95 MB | Windows | [⬇️](https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.exe) |

**Total:** 276 MB de paquetes compilados

## 🚀 Instalación Rápida

### Linux
```bash
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-linux_1.0.0_amd64.deb
sudo dpkg -i doom-linux_1.0.0_amd64.deb
doom
```

### Android
```bash
# Descargar APK
wget https://github.com/CRISTOP-bot/doom-demo/releases/download/v1.0.0/doom-v1.0.0.apk

# Instalar en dispositivo
adb install doom-v1.0.0.apk
```

### iOS
```bash
cd ports/doom-ios
npm install
cd ios && pod install && cd ..
npm run ios
```

### Windows
```bash
# Descargar y ejecutar
doom-v1.0.0.exe
```

## 📊 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Total de Código** | 25,058 líneas |
| **Archivos** | 228 |
| **Lenguajes** | C, TypeScript, Java, C++, Objective-C |
| **Plataformas** | 4 (Android, iOS, Linux, Windows) |
| **Tamaño Total** | ~276 MB (compilado) |

### Desglose por Lenguaje

- **TypeScript/JavaScript:** 12,860 líneas (51.3%)
- **Markdown:** 5,916 líneas (23.6%)
- **C/C++:** 4,420 líneas (17.6%)
- **Java:** 532 líneas (2.1%)
- **Objective-C:** 400+ líneas (1.6%)
- **CSS:** 638 líneas (2.5%)
- **JSON:** 642 líneas (2.6%)

## 📁 Estructura del Repositorio

```
doom-demo/
├── ports/
│   ├── doom-android/        # React Native + Expo + NDK
│   │   ├── app/             # Código React Native
│   │   ├── android/         # Configuración Android
│   │   ├── native/          # Código C nativo
│   │   └── README.md
│   │
│   ├── doom-ios/            # React Native + Objective-C
│   │   ├── src/             # Código React
│   │   ├── ios/             # Código nativo iOS
│   │   └── README.md
│   │
│   ├── doom-linux/          # Electron + React
│   │   ├── src/             # Código React + Electron
│   │   ├── native/          # Código C nativo
│   │   └── README.md
│   │
│   └── README.md            # Guía de plataformas
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
- Java 11+

### iOS
- macOS 12+
- Xcode 14+
- CocoaPods
- iOS 13+

### Linux
- GCC/Clang
- CMake
- GTK+ 3.0

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
- Metal rendering (iOS)
- OpenGL ES (Android)
- Electron rendering (Linux)

✅ **Menú Completo**
- Pantalla de inicio
- Configuración
- Guía de controles
- Pantalla de juego

## 📖 Documentación

### Guías por Plataforma
- [Android Guide](ports/doom-android/PORTING_GUIDE.md)
- [iOS Guide](ports/doom-ios/README.md)
- [Linux Guide](ports/doom-linux/README.md)
- [Integration Guide](ports/doom-android/INTEGRATION_GUIDE.md)

### Compilación
- [Build Instructions](releases/BUILD_INSTRUCTIONS.md)
- [Release Notes](releases/RELEASE_NOTES.md)

## 🔨 Compilación Desde Fuente

### Android
```bash
cd ports/doom-android
pnpm install
cd android
./gradlew assembleDebug
```

### iOS
```bash
cd ports/doom-ios
npm install
cd ios && pod install && cd ..
xcodebuild -workspace ios/DoomDemo.xcworkspace \
  -scheme DoomDemo -configuration Release
```

### Linux
```bash
cd ports/doom-linux
pnpm install
pnpm build
pnpm dist
```

### Windows (Original)
```bash
cd src
cmake -B build
cmake --build build --config Release
```

## 🐛 Bugs Conocidos

- Módulo nativo de Linux requiere compilación manual en algunos sistemas
- Algunos efectos visuales pueden variar según la GPU
- iOS requiere macOS para compilación

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo licencia MIT. Ver `LICENSE` para más detalles.

## 📞 Soporte

Para reportar bugs o solicitar features, abre un issue en GitHub.

## 🎯 Roadmap Futuro

- [ ] Compilación automática con CI/CD
- [ ] Publicación en App Store y Google Play
- [ ] Optimización de rendimiento
- [ ] Soporte para macOS
- [ ] Soporte para WebGL (navegador)
- [ ] Multijugador en línea
- [ ] Mods y customización

---

**Versión:** 1.0.0
**Fecha:** 18 de Junio, 2026
**Plataformas:** 4 (Android, iOS, Linux, Windows)
**Código Total:** 25,058 líneas
**Licencia:** MIT

**Creado con ❤️ por CRISTOP**

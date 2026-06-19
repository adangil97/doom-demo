# Doom Demo - Unix/BSD Edition

Doom Demo portado a todos los sistemas Unix/BSD (Linux, FreeBSD, OpenBSD, NetBSD, Solaris, AIX, etc.) usando Electron + React.

## 🐧 Plataformas Soportadas

- ✅ **Linux** (todas las distribuciones)
- ✅ **FreeBSD**
- ✅ **OpenBSD**
- ✅ **NetBSD**
- ✅ **Solaris/SunOS**
- ✅ **AIX**
- ✅ **Cualquier Unix POSIX-compatible**

## 🚀 Características

- ✅ Interfaz moderna con React
- ✅ Electron para empaquetado nativo
- ✅ Controles optimizados (teclado/mouse)
- ✅ Detección automática de plataforma
- ✅ Múltiples formatos de distribución
- ✅ Soporte para gestores de paquetes

## 📋 Requisitos

- Unix/BSD compatible
- Node.js 18+
- npm o pnpm

## 🔧 Instalación

\`\`\`bash
npm install
npm run dev
\`\`\`

## 📁 Estructura del Proyecto

\`\`\`
doom-unix-bsd/
├── src/
│   ├── App.tsx
│   ├── App.css
│   ├── main.ts
│   ├── main.tsx
│   └── preload.ts
├── public/
│   └── index.html
├── native/
└── package.json
\`\`\`

## 🎮 Controles

- **WASD:** Movimiento
- **Space:** Saltar
- **E:** Usar
- **Mouse Click:** Disparar
- **Scroll:** Cambiar arma

## 🔨 Compilación para Distribución

\`\`\`bash
# Todas las plataformas
npm run dist

# Formatos específicos
npm run dist:appimage    # AppImage (portable)
npm run dist:deb         # Debian/Ubuntu
npm run dist:rpm         # RedHat/Fedora
npm run dist:tar         # TAR.GZ (universal)
npm run dist:snap        # Snap (Ubuntu)
\`\`\`

## 📊 Especificaciones Técnicas

| Aspecto | Detalle |
|--------|---------|
| Framework | Electron 31 |
| Lenguaje | TypeScript 5.0 |
| UI | React 19 |
| Build | Vite |
| Portabilidad | POSIX-compatible |

## 🌐 Distribuciones Soportadas

- Debian/Ubuntu
- RedHat/Fedora/CentOS
- Arch Linux
- Gentoo
- Alpine
- FreeBSD
- OpenBSD
- NetBSD
- Solaris
- AIX

---

**Versión:** 1.0.0 | **Licencia:** MIT | **Unix/BSD:** Compatible

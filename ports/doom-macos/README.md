# Doom Demo - macOS Edition

Doom Demo portado a macOS usando Electron + React con integración de código C nativo.

## 🚀 Características

- ✅ Interfaz moderna con React
- ✅ Electron para empaquetado nativo
- ✅ Controles optimizados para macOS (teclado/mouse)
- ✅ Soporte para Metal rendering
- ✅ Integración con código C nativo (Objective-C bridge)
- ✅ Dark mode nativo
- ✅ Distribución como DMG y ZIP

## 📋 Requisitos

- macOS 10.13+
- Node.js 18+
- npm o pnpm

## 🔧 Instalación

\`\`\`bash
npm install
npm run dev
\`\`\`

## 📁 Estructura del Proyecto

\`\`\`
doom-macos/
├── src/
│   ├── App.tsx
│   ├── App.css
│   ├── main.ts
│   └── preload.ts
├── public/
│   └── index.html
├── macos/
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
npm run dist
\`\`\`

Genera:
- Doom.dmg (instalador)
- Doom-1.0.0.zip (archivo comprimido)

## 📊 Especificaciones Técnicas

| Aspecto | Detalle |
|--------|---------|
| Framework | Electron 31 |
| Lenguaje | TypeScript 5.0 |
| UI | React 19 |
| Rendering | Metal (macOS) |
| Build | Vite |

---

**Versión:** 1.0.0 | **Licencia:** MIT | **macOS:** 10.13+

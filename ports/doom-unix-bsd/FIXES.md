# Correcciones Linux/Unix/BSD

## Error 1: Rutas no portables
- Archivo: src/main.ts
- Solución: Usar path.join() en lugar de strings

## Error 2: Señales POSIX
- Archivo: src/main.ts
- Solución: Agregar handlers para SIGTERM/SIGINT

Estado: ✅ CORREGIDO

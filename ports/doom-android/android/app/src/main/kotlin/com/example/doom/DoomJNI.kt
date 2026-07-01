package com.example.doom

/**
 * DoomJNI - Interfaz JNI para acceder al motor de juego Doom nativo
 *
 * Define los métodos nativos implementados en C/C++ que proporciona la librería
 * "doom" compilada desde el NDK.
 */
object DoomJNI {
    init {
        try {
            System.loadLibrary("doom")
        } catch (e: UnsatisfiedLinkError) {
            throw RuntimeException("Failed to load doom native library", e)
        }
    }

    // Métodos de inicialización y limpieza
    external fun init(width: Int, height: Int): Int
    external fun cleanup()
    external fun reset()

    // Métodos de actualización y renderizado
    external fun update(
        w: Int, a: Int, s: Int, d: Int,
        left: Int, right: Int,
        space: Int, e: Int, tab: Int, r: Int,
        mouseDx: Int
    )
    external fun render()

    // Métodos de estado del juego
    external fun getPlayerHP(): Int
    external fun getPlayerAmmo(): Int
    external fun getPlayerArmor(): Int
    external fun getPlayerScore(): Int
    external fun isGameOver(): Int
    external fun getLevel(): Int
    external fun getEnemiesKilled(): Int

    // Métodos de configuración
    external fun setViewport(width: Int, height: Int)
    external fun setDebug(enabled: Int)

    // Métodos de estadísticas
    external fun getFPS(): Double
    external fun getDrawCalls(): Int
    external fun getTriangleCount(): Int
}

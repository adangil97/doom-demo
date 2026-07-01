package com.example.doom

import android.util.Log
import com.facebook.react.bridge.*

/**
 * DoomModule - Módulo React Native en Kotlin para el motor de juego Doom
 *
 * Proporciona métodos JavaScript para interactuar con el motor de juego C/C++
 * a través de JNI con error handling completo y logging.
 */
class DoomModule(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    companion object {
        private const val TAG = "DoomModule"
        private const val MODULE_NAME = "DoomModule"
    }

    init {
        Log.i(TAG, "DoomModule initialized")
    }

    override fun getName(): String = MODULE_NAME

    /**
     * Inicializa el motor de juego Doom
     *
     * @param width Ancho de la pantalla
     * @param height Alto de la pantalla
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun init(width: Int, height: Int, promise: Promise) {
        try {
            Log.d(TAG, "Initializing Doom engine with dimensions: $width x $height")

            if (width <= 0 || height <= 0) {
                throw IllegalArgumentException("Invalid dimensions: width=$width, height=$height")
            }

            val result = DoomJNI.init(width, height)
            when (result) {
                1 -> {
                    Log.i(TAG, "Doom engine initialized successfully")
                    promise.resolve(true)
                }
                else -> {
                    val error = "Failed to initialize Doom engine (code: $result)"
                    Log.e(TAG, error)
                    promise.reject("INIT_ERROR", error)
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Exception in init", e)
            promise.reject("INIT_ERROR", e.message, e)
        }
    }

    /**
     * Limpia y libera recursos del motor de juego
     *
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun cleanup(promise: Promise) {
        try {
            Log.d(TAG, "Cleaning up Doom engine")
            DoomJNI.cleanup()
            Log.i(TAG, "Doom engine cleaned up successfully")
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in cleanup", e)
            promise.reject("CLEANUP_ERROR", e.message, e)
        }
    }

    /**
     * Actualiza el estado del juego basado en entrada del usuario
     *
     * @param w Tecla W presionada (booleano como int)
     * @param a Tecla A presionada
     * @param s Tecla S presionada
     * @param d Tecla D presionada
     * @param left Flecha izquierda presionada
     * @param right Flecha derecha presionada
     * @param space Barra espaciadora presionada
     * @param e Tecla E presionada
     * @param tab Tecla Tab presionada
     * @param r Tecla R presionada
     * @param mouseDx Movimiento del mouse en X
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun update(
        w: Int, a: Int, s: Int, d: Int,
        left: Int, right: Int,
        space: Int, e: Int, tab: Int, r: Int,
        mouseDx: Int,
        promise: Promise
    ) {
        try {
            DoomJNI.update(w, a, s, d, left, right, space, e, tab, r, mouseDx)
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in update", e)
            promise.reject("UPDATE_ERROR", e.message, e)
        }
    }

    /**
     * Renderiza un frame del juego
     *
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun render(promise: Promise) {
        try {
            DoomJNI.render()
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in render", e)
            promise.reject("RENDER_ERROR", e.message, e)
        }
    }

    /**
     * Obtiene el estado actual del juego
     *
     * @param promise Promise que retorna WritableMap con el estado
     */
    @ReactMethod
    fun getGameState(promise: Promise) {
        try {
            val state = WritableNativeMap().apply {
                putInt("hp", DoomJNI.getPlayerHP())
                putInt("ammo", DoomJNI.getPlayerAmmo())
                putInt("armor", DoomJNI.getPlayerArmor())
                putInt("score", DoomJNI.getPlayerScore())
                putBoolean("gameOver", DoomJNI.isGameOver() == 1)
                putInt("level", DoomJNI.getLevel())
                putInt("enemiesKilled", DoomJNI.getEnemiesKilled())
            }
            Log.d(TAG, "Game state: hp=${state.getInt("hp")}, ammo=${state.getInt("ammo")}")
            promise.resolve(state)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in getGameState", e)
            promise.reject("GET_STATE_ERROR", e.message, e)
        }
    }

    /**
     * Reinicia el juego
     *
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun reset(promise: Promise) {
        try {
            Log.d(TAG, "Resetting game")
            DoomJNI.reset()
            Log.i(TAG, "Game reset successfully")
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in reset", e)
            promise.reject("RESET_ERROR", e.message, e)
        }
    }

    /**
     * Establece el viewport (área de renderizado)
     *
     * @param width Ancho del viewport
     * @param height Alto del viewport
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun setViewport(width: Int, height: Int, promise: Promise) {
        try {
            if (width <= 0 || height <= 0) {
                throw IllegalArgumentException("Invalid viewport dimensions: width=$width, height=$height")
            }
            DoomJNI.setViewport(width, height)
            Log.d(TAG, "Viewport set to $width x $height")
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in setViewport", e)
            promise.reject("VIEWPORT_ERROR", e.message, e)
        }
    }

    /**
     * Obtiene estadísticas de rendimiento
     *
     * @param promise Promise que retorna WritableMap con estadísticas
     */
    @ReactMethod
    fun getStats(promise: Promise) {
        try {
            val stats = WritableNativeMap().apply {
                putDouble("fps", DoomJNI.getFPS())
                putInt("drawCalls", DoomJNI.getDrawCalls())
                putInt("triangles", DoomJNI.getTriangleCount())
            }
            promise.resolve(stats)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in getStats", e)
            promise.reject("STATS_ERROR", e.message, e)
        }
    }

    /**
     * Habilita o deshabilita el debug
     *
     * @param enabled True para habilitar debug
     * @param promise Promise para retornar resultado
     */
    @ReactMethod
    fun setDebug(enabled: Boolean, promise: Promise) {
        try {
            DoomJNI.setDebug(if (enabled) 1 else 0)
            Log.d(TAG, "Debug mode set to $enabled")
            promise.resolve(true)
        } catch (e: Exception) {
            Log.e(TAG, "Exception in setDebug", e)
            promise.reject("DEBUG_ERROR", e.message, e)
        }
    }
}

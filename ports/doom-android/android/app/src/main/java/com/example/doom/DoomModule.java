package com.example.doom;

import android.util.Log;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.Arguments;

/**
 * DoomModule - Módulo React Native para exponer la funcionalidad del juego Doom
 * 
 * Este módulo proporciona métodos JavaScript para interactuar con el motor de juego
 * C a través de JNI.
 */
public class DoomModule extends NativeModule {
    private static final String TAG = "DoomModule";
    private static final String NAME = "DoomModule";

    public DoomModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return NAME;
    }

    /**
     * Inicializa el motor de juego
     */
    @ReactMethod
    public void init(int width, int height, Promise promise) {
        try {
            int result = DoomJNI.init(width, height);
            if (result == 1) {
                Log.i(TAG, "Doom engine initialized successfully");
                promise.resolve(true);
            } else {
                Log.e(TAG, "Failed to initialize Doom engine");
                promise.reject("INIT_ERROR", "Failed to initialize Doom engine");
            }
        } catch (Exception e) {
            Log.e(TAG, "Exception in init: " + e.getMessage());
            promise.reject("INIT_ERROR", e);
        }
    }

    /**
     * Limpia y libera recursos del motor de juego
     */
    @ReactMethod
    public void cleanup(Promise promise) {
        try {
            DoomJNI.cleanup();
            Log.i(TAG, "Doom engine cleaned up");
            promise.resolve(true);
        } catch (Exception e) {
            Log.e(TAG, "Exception in cleanup: " + e.getMessage());
            promise.reject("CLEANUP_ERROR", e);
        }
    }

    /**
     * Actualiza el estado del juego
     */
    @ReactMethod
    public void update(int w, int a, int s, int d,
                       int left, int right,
                       int space, int e, int tab, int r,
                       int mouseDx, Promise promise) {
        try {
            DoomJNI.update(w, a, s, d, left, right, space, e, tab, r, mouseDx);
            promise.resolve(true);
        } catch (Exception e) {
            Log.e(TAG, "Exception in update: " + e.getMessage());
            promise.reject("UPDATE_ERROR", e);
        }
    }

    /**
     * Renderiza un frame del juego
     */
    @ReactMethod
    public void render(Promise promise) {
        try {
            DoomJNI.render();
            promise.resolve(true);
        } catch (Exception e) {
            Log.e(TAG, "Exception in render: " + e.getMessage());
            promise.reject("RENDER_ERROR", e);
        }
    }

    /**
     * Obtiene el estado actual del juego
     */
    @ReactMethod
    public void getGameState(Promise promise) {
        try {
            WritableMap state = Arguments.createMap();
            state.putInt("hp", DoomJNI.getPlayerHP());
            state.putInt("ammo", DoomJNI.getPlayerAmmo());
            state.putInt("score", DoomJNI.getPlayerScore());
            state.putBoolean("gameOver", DoomJNI.isGameOver() == 1);
            state.putInt("level", DoomJNI.getLevel());
            
            promise.resolve(state);
        } catch (Exception e) {
            Log.e(TAG, "Exception in getGameState: " + e.getMessage());
            promise.reject("STATE_ERROR", e);
        }
    }

    /**
     * Reinicia el juego
     */
    @ReactMethod
    public void reset(Promise promise) {
        try {
            DoomJNI.reset();
            Log.i(TAG, "Game reset");
            promise.resolve(true);
        } catch (Exception e) {
            Log.e(TAG, "Exception in reset: " + e.getMessage());
            promise.reject("RESET_ERROR", e);
        }
    }

    /**
     * Establece el viewport
     */
    @ReactMethod
    public void setViewport(int width, int height, Promise promise) {
        try {
            DoomJNI.setViewport(width, height);
            promise.resolve(true);
        } catch (Exception e) {
            Log.e(TAG, "Exception in setViewport: " + e.getMessage());
            promise.reject("VIEWPORT_ERROR", e);
        }
    }
}

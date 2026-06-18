package com.example.doom;

/**
 * DoomJNI - Interfaz Java Native Interface para el motor de juego Doom
 * 
 * Esta clase proporciona métodos para interactuar con el código C compilado
 * del motor de juego Doom a través de JNI.
 */
public class DoomJNI {
    static {
        System.loadLibrary("doom");
    }

    /**
     * Inicializa el motor de juego
     * @param width Ancho de la pantalla
     * @param height Alto de la pantalla
     * @return 1 si fue exitoso, 0 si falló
     */
    public static native int init(int width, int height);

    /**
     * Limpia y libera recursos del motor de juego
     */
    public static native void cleanup();

    /**
     * Actualiza el estado del juego basado en la entrada del usuario
     * @param w Tecla W presionada
     * @param a Tecla A presionada
     * @param s Tecla S presionada
     * @param d Tecla D presionada
     * @param left Flecha izquierda presionada
     * @param right Flecha derecha presionada
     * @param space Espacio presionado
     * @param e Tecla E presionada
     * @param tab Tab presionado
     * @param r Tecla R presionada
     * @param mouseDx Movimiento del mouse en X
     */
    public static native void update(int w, int a, int s, int d,
                                     int left, int right,
                                     int space, int e, int tab, int r,
                                     int mouseDx);

    /**
     * Renderiza un frame del juego
     */
    public static native void render();

    /**
     * Obtiene la salud actual del jugador
     * @return Puntos de salud del jugador
     */
    public static native int getPlayerHP();

    /**
     * Obtiene la munición actual del jugador
     * @return Cantidad de munición
     */
    public static native int getPlayerAmmo();

    /**
     * Obtiene la puntuación actual del jugador
     * @return Puntuación del jugador
     */
    public static native int getPlayerScore();

    /**
     * Verifica si el juego ha terminado
     * @return 1 si el juego terminó, 0 si continúa
     */
    public static native int isGameOver();

    /**
     * Obtiene el nivel actual
     * @return Número del nivel
     */
    public static native int getLevel();

    /**
     * Reinicia el juego
     */
    public static native void reset();

    /**
     * Establece el viewport (área de renderizado)
     * @param width Ancho del viewport
     * @param height Alto del viewport
     */
    public static native void setViewport(int width, int height);
}

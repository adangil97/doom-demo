cmake_minimum_required(VERSION 3.22.1)

project(doom)

# Configuración de compilación
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -O2")

# Agregar la librería compartida
add_library(doom SHARED
    src/main/jni/doom_jni.c
    src/main/jni/game_logic.c
    src/main/jni/opengl_es_render.c
)

# Incluir directorios
target_include_directories(doom PRIVATE
    src/main/jni
)

# Enlazar librerías del sistema
target_link_libraries(doom
    log
    GLESv2
    android
)

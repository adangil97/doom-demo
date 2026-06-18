LOCAL_PATH := $(call my-dir)

# Librería compartida del juego Doom
include $(CLEAR_VARS)

LOCAL_MODULE := doom

LOCAL_SRC_FILES := \
    doom_jni.c \
    game_logic.c \
    opengl_es_render.c

LOCAL_CFLAGS := -Wall -Wextra -O2

LOCAL_LDLIBS := -llog -lGLESv2 -landroid

include $(BUILD_SHARED_LIBRARY)

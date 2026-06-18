#include "doom_core.h"
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <math.h>
#include <stdio.h>

/* ==================== Contexto OpenGL ES ==================== */

static struct {
    GLuint program;
    GLint position_attr;
    GLint color_attr;
    GLint matrix_uniform;
    int initialized;
    int width;
    int height;
} gl_context = {0};

/* ==================== Shaders ==================== */

static const char *vertex_shader_src = 
    "#version 100\n"
    "uniform mat4 uMatrix;\n"
    "attribute vec4 aPosition;\n"
    "attribute vec4 aColor;\n"
    "varying vec4 vColor;\n"
    "void main() {\n"
    "  gl_Position = uMatrix * aPosition;\n"
    "  vColor = aColor;\n"
    "}\n";

static const char *fragment_shader_src =
    "#version 100\n"
    "precision mediump float;\n"
    "varying vec4 vColor;\n"
    "void main() {\n"
    "  gl_FragColor = vColor;\n"
    "}\n";

/* ==================== Utilidades de Shaders ==================== */

static GLuint compile_shader(GLenum type, const char *src) {
    GLuint shader = glCreateShader(type);
    if (!shader) return 0;

    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);

    GLint compiled = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    if (!compiled) {
        char log[512];
        glGetShaderInfoLog(shader, sizeof(log), NULL, log);
        printf("[ERROR] Shader compilation failed: %s\n", log);
        glDeleteShader(shader);
        return 0;
    }

    return shader;
}

static GLuint create_program(const char *vs_src, const char *fs_src) {
    GLuint vs = compile_shader(GL_VERTEX_SHADER, vs_src);
    GLuint fs = compile_shader(GL_FRAGMENT_SHADER, fs_src);

    if (!vs || !fs) {
        if (vs) glDeleteShader(vs);
        if (fs) glDeleteShader(fs);
        return 0;
    }

    GLuint program = glCreateProgram();
    glAttachShader(program, vs);
    glAttachShader(program, fs);
    glLinkProgram(program);

    GLint linked = 0;
    glGetProgramiv(program, GL_LINK_STATUS, &linked);
    if (!linked) {
        char log[512];
        glGetProgramInfoLog(program, sizeof(log), NULL, log);
        printf("[ERROR] Program linking failed: %s\n", log);
        glDeleteProgram(program);
        glDeleteShader(vs);
        glDeleteShader(fs);
        return 0;
    }

    glDeleteShader(vs);
    glDeleteShader(fs);
    return program;
}

/* ==================== Inicializacion ==================== */

int opengl_es_init(int width, int height) {
    gl_context.width = width;
    gl_context.height = height;

    /* Crear programa de shaders */
    gl_context.program = create_program(vertex_shader_src, fragment_shader_src);
    if (!gl_context.program) {
        printf("[ERROR] Failed to create shader program\n");
        return 0;
    }

    /* Obtener ubicaciones de atributos y uniformes */
    gl_context.position_attr = glGetAttribLocation(gl_context.program, "aPosition");
    gl_context.color_attr = glGetAttribLocation(gl_context.program, "aColor");
    gl_context.matrix_uniform = glGetUniformLocation(gl_context.program, "uMatrix");

    /* Configuración inicial de OpenGL ES */
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    glViewport(0, 0, width, height);

    gl_context.initialized = 1;
    printf("[OpenGL ES] Initialized successfully\n");

    return 1;
}

void opengl_es_cleanup(void) {
    if (gl_context.program) {
        glDeleteProgram(gl_context.program);
        gl_context.program = 0;
    }
    gl_context.initialized = 0;
}

/* ==================== Renderizado ==================== */

void opengl_es_begin_frame(void) {
    if (!gl_context.initialized) return;
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

void opengl_es_end_frame(void) {
    if (!gl_context.initialized) return;
    /* El buffer se intercambia en la capa de Android */
}

void opengl_es_set_viewport(int width, int height) {
    if (!gl_context.initialized) return;
    gl_context.width = width;
    gl_context.height = height;
    glViewport(0, 0, width, height);
}

/* ==================== Dibujado de Primitivas ==================== */

static void draw_cube(float x, float y, float z, float size, 
                      float r, float g, float b) {
    if (!gl_context.initialized) return;

    float s = size / 2.0f;

    /* Vertices del cubo */
    GLfloat vertices[] = {
        /* Frente */
        -s, -s, s,   s, -s, s,   s, s, s,   -s, s, s,
        /* Atras */
        -s, -s, -s,  -s, s, -s,  s, s, -s,  s, -s, -s,
        /* Arriba */
        -s, s, -s,   -s, s, s,   s, s, s,   s, s, -s,
        /* Abajo */
        -s, -s, -s,  s, -s, -s,  s, -s, s,  -s, -s, s,
        /* Derecha */
        s, -s, -s,   s, s, -s,   s, s, s,   s, -s, s,
        /* Izquierda */
        -s, -s, -s,  -s, -s, s,  -s, s, s,  -s, s, -s,
    };

    GLfloat colors[] = {
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
        r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,  r, g, b, 1.0f,
    };

    glUseProgram(gl_context.program);

    glEnableVertexAttribArray(gl_context.position_attr);
    glEnableVertexAttribArray(gl_context.color_attr);

    glVertexAttribPointer(gl_context.position_attr, 3, GL_FLOAT, GL_FALSE, 12, vertices);
    glVertexAttribPointer(gl_context.color_attr, 4, GL_FLOAT, GL_FALSE, 16, colors);

    glDrawArrays(GL_TRIANGLE_STRIP, 0, 24);

    glDisableVertexAttribArray(gl_context.position_attr);
    glDisableVertexAttribArray(gl_context.color_attr);
}

/* ==================== Renderizado de Escena ==================== */

void opengl_es_draw_scene(GameState *game) {
    if (!gl_context.initialized || !game) return;

    glUseProgram(gl_context.program);

    /* Dibujar jugador (cubo azul) */
    draw_cube(game->player.x, game->player.y, 0.0f, 0.5f, 0.0f, 0.5f, 1.0f);

    /* Dibujar enemigos (pirámides rojas) */
    for (int i = 0; i < game->enemy_count; i++) {
        if (game->enemies[i].active) {
            draw_cube(game->enemies[i].x, game->enemies[i].y, 0.0f, 0.5f, 1.0f, 0.0f, 0.0f);
        }
    }

    /* Dibujar balas (esferas amarillas) */
    for (int i = 0; i < game->bullet_count; i++) {
        if (game->bullets[i].active) {
            draw_cube(game->bullets[i].x, game->bullets[i].y, game->bullets[i].z, 
                     0.1f, 1.0f, 1.0f, 0.0f);
        }
    }

    /* Dibujar paredes */
    for (int y = 0; y < 32; y++) {
        for (int x = 0; x < 32; x++) {
            if (game->map[y][x] == 1) {
                draw_cube(x, y, 0.5f, 1.0f, 0.5f, 0.5f, 0.5f);
            }
        }
    }
}

#ifndef OPENGL_RENDER_H
#define OPENGL_RENDER_H

#include <windows.h>
#include "opengl_config.h"
#include "game_shared.h"

typedef struct {
    HWND hwnd;
    HDC hdc;
    HGLRC hglrc;
    int initialized;
    float aspect_ratio;
} OpenGLContext;

/* Inicializacion y limpieza */
int opengl_init(HWND hwnd, OpenGLContext *ctx);
void opengl_cleanup(OpenGLContext *ctx);

/* Renderizado basico */
void opengl_begin_frame(void);
void opengl_end_frame(OpenGLContext *ctx);
void opengl_clear_screen(float r, float g, float b, float a);
void opengl_set_projection(float width, float height);
void opengl_set_viewport(int x, int y, int width, int height);

/* Dibujado de primitivas */
void opengl_draw_cube(float x, float y, float z, float size, float r, float g, float b);
void opengl_draw_pyramid(float x, float y, float z, float size, float r, float g, float b);
void opengl_draw_sphere(float x, float y, float z, float radius, float r, float g, float b);
void opengl_draw_quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, 
                      float r, float g, float b);
void opengl_draw_triangle(float x1, float y1, float x2, float y2, float x3, float y3, 
                          float r, float g, float b);
void opengl_draw_line(float x1, float y1, float x2, float y2, float width, float r, float g, float b);

/* Renderizado de game entities */
void opengl_draw_player(float x, float y, float angle);
void opengl_draw_enemy(float x, float y, int hp);
void opengl_draw_bullet(float x, float y, float vx, float vy);
void opengl_draw_map_wall(int map_x, int map_y, float wall_height);
void opengl_draw_hud(GameState *game);

/* Iluminacion */
void opengl_setup_lighting(void);
void opengl_set_ambient_light(float r, float g, float b);
void opengl_add_light(Light *light);

/* Transformaciones */
void opengl_push_matrix(void);
void opengl_pop_matrix(void);
void opengl_translate(float x, float y, float z);
void opengl_rotate(float angle, float x, float y, float z);
void opengl_scale(float x, float y, float z);

/* Utilidades */
void opengl_set_color(float r, float g, float b, float a);
void opengl_enable_blend(void);
void opengl_disable_blend(void);
void opengl_draw_text_2d(float x, float y, const char *text);

#endif

#ifndef DOOM_GRAPHICS_H
#define DOOM_GRAPHICS_H

#include "opengl_config.h"
#include "game_shared.h"

/* Estilos de textura tipo DOOM */
typedef enum {
    TEXTURE_STONE = 0,
    TEXTURE_BRICK = 1,
    TEXTURE_METAL = 2,
    TEXTURE_WOOD = 3,
    TEXTURE_LAVA = 4,
    TEXTURE_BLOOD = 5,
    TEXTURE_SKULL = 6,
    TEXTURE_MAX = 7
} TextureType;

/* Estructura de material */
typedef struct {
    float r, g, b;
    float roughness;
    TextureType type;
    int has_pattern;
} Material;

/* Estructura de sector (area del mapa) */
typedef struct {
    float floor_height;
    float ceil_height;
    Material floor_material;
    Material ceil_material;
    Material wall_material;
} Sector;

/* Funciones de renderizado estilo DOOM */

/* Raycasting y vista 3D */
void doom_setup_3d_view(float player_x, float player_y, float player_angle);
void doom_render_3d_scene(GameState *game);
void doom_render_walls(GameState *game);
void doom_render_floor_ceiling(GameState *game);
void doom_render_sprites(GameState *game);

/* Renderizado de texturas */
void doom_draw_textured_wall(float x1, float y1, float x2, float y2, 
                             float h1, float h2, TextureType texture);
void doom_draw_floor_tile(float x, float y, float size, TextureType texture);
void doom_draw_ceiling_tile(float x, float y, float size, TextureType texture);

/* Genera texturas procedurales tipo DOOM */
void doom_generate_stone_texture(void);
void doom_generate_brick_texture(void);
void doom_generate_metal_texture(void);
void doom_generate_blood_texture(void);
void doom_generate_lava_texture(void);
void doom_generate_skull_texture(void);

/* Renderizado de sprites (enemigos, items) */
void doom_draw_demon_sprite(float x, float y, float z, int animation_frame);
void doom_draw_weapon_sprite(float x, float y, float angle, int frame);
void doom_draw_item_sprite(float x, float y, int item_type);
void doom_draw_blood_splatter(float x, float y, int intensity);

/* Iluminacion dinamica tipo DOOM */
void doom_apply_sector_lighting(Sector *sector, float ambient);
void doom_apply_dynamic_light(float x, float y, float z, float radius, float intensity);
void doom_apply_muzzle_flash(float x, float y, float intensity);
void doom_apply_torch_light(float x, float y, float z, float radius);

/* Efectos visuales */
void doom_draw_blood_pool(float x, float y, int size);
void doom_draw_corpse(float x, float y);
void doom_draw_explosion(float x, float y, float z, int frame);
void doom_draw_particle_effect(float x, float y, float z, int type, int intensity);

/* HUD estilo DOOM */
void doom_draw_hud(GameState *game);
void doom_draw_weapon(GameState *game, int frame);
void doom_draw_ammo_counter(int ammo);
void doom_draw_health_bar(int hp, int armor);
void doom_draw_minimap(GameState *game);
void doom_draw_face_status(int hp);

/* Utilidades */
Material doom_create_material(float r, float g, float b, TextureType type);
void doom_apply_wall_shadow(float distance);
void doom_apply_fog_effect(float distance);

#endif

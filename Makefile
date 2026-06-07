# Compilador y flags
CC = gcc
CFLAGS = -Wall -I./src

# Directorios
SRC_DIR = src
BIN_DIR = bin

# Archivos fuente
SRC = $(SRC_DIR)/main.c \
      $(SRC_DIR)/game_dll.c \
      $(SRC_DIR)/doom_graphics.c \
      $(SRC_DIR)/opengl_render.c

# Objetos
OBJ = $(SRC:.c=.o)

# Ejecutables
DLL = $(BIN_DIR)/game_dll.dll
EXE = $(BIN_DIR)/doom_plus_gl.exe

# Regla por defecto
all: $(DLL) $(EXE)

# Compilar DLL
$(DLL): $(SRC_DIR)/game_dll.c $(SRC_DIR)/doom_graphics.c $(SRC_DIR)/opengl_render.c
	$(CC) -shared -o $@ $^ -lm

# Compilar ejecutable
$(EXE): $(SRC_DIR)/main.c
	$(CC) $^ -o $@ -mwindows -lgdi32 -luser32 -lopengl32 -lglu32

# Limpiar archivos compilados
clean:
	rm -f $(SRC_DIR)/*.o $(DLL) $(EXE)

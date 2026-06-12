# =========================
# COMPILADOR
# =========================
CC = gcc
CFLAGS = -Wall -O2 -I./src

# =========================
# DIRECTORIOS
# =========================
SRC_DIR = src
BIN_DIR = bin

# =========================
# ARCHIVOS
# =========================
DLL_SRC = $(SRC_DIR)/game_dll.c \
          $(SRC_DIR)/doom_graphics.c \
          $(SRC_DIR)/opengl_render.c

EXE_SRC = $(SRC_DIR)/main.c

DLL = $(BIN_DIR)/game_dll.dll
EXE = $(BIN_DIR)/doom_plus_gl.exe

# =========================
# DEFAULT
# =========================
all: $(BIN_DIR) $(DLL) $(EXE)

# =========================
# CREAR BIN SI NO EXISTE
# =========================
$(BIN_DIR):
	if not exist $(BIN_DIR) mkdir $(BIN_DIR)

# =========================
# COMPILAR OBJETOS DLL
# =========================
DLL_OBJ = $(DLL_SRC:.c=.o)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# =========================
# DLL (lógica del juego)
# =========================
$(DLL): $(DLL_OBJ)
	$(CC) -shared -o $@ $^ -lm

# =========================
# EXE (motor OpenGL + WinAPI)
# =========================
$(EXE): $(EXE_SRC)
	$(CC) $^ -o $@ -mwindows -lgdi32 -luser32 -lopengl32 -lglu32

# =========================
# LIMPIAR
# =========================
clean:
	del /Q src\*.o
	del /Q bin\*.dll bin\*.exe

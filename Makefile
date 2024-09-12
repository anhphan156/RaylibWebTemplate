WIDTH := 800
HEIGHT := 600
TITLE := \"Game\"

CC := gcc
LDFLAGS := -lm -lraylib
CFLAGS := -Wall -DWIDTH=$(WIDTH) -DHEIGHT=$(HEIGHT) -DTITLE=$(TITLE)

SRC_DIR := src
BUILD_DIR := build
INCLUDE_DIR := include
WEB_GAME_DIR := game
GAME_ASSETS_DIR := assets
EMSCRIPTEN_SHELL := minshell.html

SRCS := $(shell find $(SRC_DIR) -name '*.c')
OBJS := $(SRCS:%.c=%.o)
EXECUTABLE := out
TEST_EXECUTABLE := test_out

.PHONY: all clean web test

all: CFLAGS += -g
all: $(OBJS)
	$(CC) -o $(EXECUTABLE) $(addprefix $(BUILD_DIR)/,$(notdir $^)) $(LDFLAGS)

web: CC:=emcc
web: LDFLAGS := -0 -lm ./dependencies/lib/libraylib.a -s FORCE_FILESYSTEM=1 -s USE_GLFW=3 --shell-file $(EMSCRIPTEN_SHELL) --preload-file $(GAME_ASSETS_DIR)
web: CFLAGS += -DPLATFORM_WEB
web: $(OBJS)
	@mkdir -p $(WEB_GAME_DIR)
	$(CC) -o $(WEB_GAME_DIR)/index.html $(addprefix $(BUILD_DIR)/,$(notdir $^)) $(LDFLAGS)

test: CFLAGS += -DTEST
test: $(OBJS)
	$(CC) -o $(TEST_EXECUTABLE) $(addprefix $(BUILD_DIR)/,$(notdir $^)) $(LDFLAGS)

$(OBJS): %.o: %.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $(addprefix $(BUILD_DIR)/,$(notdir $@)) -I$(INCLUDE_DIR)

run:
	./$(EXECUTABLE)

run_test:
	./$(TEST_EXECUTABLE)

run_web:
	emrun game

debug:
	gdb ./$(TEST_EXECUTABLE)

leak-check:
	valgrind --leak-check=full --log-file=leak.txt ./$(EXECUTABLE)

clean:
	rm -rf $(BUILD_DIR) $(EXECUTABLE) $(TEST_EXECUTABLE) $(WEB_GAME_DIR)

raylib:
	emcc -o build/rcore.o -c ./dependencies/raylib/src/rcore.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	emcc -o build/rshapes.o -c ./dependencies/raylib/src/rshapes.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	emcc -o build/rtextures.o -c ./dependencies/raylib/src/rtextures.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	emcc -o build/rtext.o -c ./dependencies/raylib/src/rtext.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	emcc -o build/rmodels.o -c ./dependencies/raylib/src/rmodels.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	emcc -o build/utils.o -c ./dependencies/raylib/src/utils.c -Os -Wall -DPLATFORM_WEB
	emcc -o build/raudio.o -c ./dependencies/raylib/src/raudio.c -Os -Wall -DPLATFORM_WEB

	emar rcs dependencies/raylib/lib/libraylib.a build/rcore.o build/rshapes.o build/rtextures.o build/rtext.o build/rmodels.o build/utils.o build/raudio.o

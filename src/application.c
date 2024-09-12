#include "application.h"
#include "scene/main_scene.h"
#include <raylib.h>
#include <stdio.h>

#ifdef PLATFORM_WEB
#include <emscripten/emscripten.h>
#include <emscripten/html5.h>
#endif

void app_init() {
    InitWindow(WIDTH, HEIGHT, TITLE);
    SetTargetFPS(60);
}

void app_run() {

#ifdef PLATFORM_WEB
    emscripten_set_main_loop(update_frame, 0, 1);
#else
    while (!WindowShouldClose()) {
        update_frame();
    }
#endif
}
void app_destroy() {
    CloseWindow();
}

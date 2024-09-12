#include "scene/main_scene.h"
#include "raylib.h"

void update_frame() {
    BeginDrawing();
    ClearBackground(BLACK);
    DrawText("Hello World", WIDTH / 3, HEIGHT / 3, 30, WHITE);
    EndDrawing();
}

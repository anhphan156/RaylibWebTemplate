# Raylib Web Game Template

## Dependencies 
- gcc
- [raylib](https://github.com/raysan5/raylib)
- [emscripten](https://emscripten.org/)

## Build Instructions

### Build a Native App

Install the required dependencies (gcc and raylib). Then hit `make`.

### Build a Web


Install the required dependencies (gcc, raylib, and emscripten). Make sure emcc is in the shell's environment. Then hit `make web`.
Raylib needs to be recompiled to support web assembly. This repo already included the needed raylib lib file. However, to recompile, refer [here](https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5)).

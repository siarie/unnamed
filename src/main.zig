const std = @import("std");
const sdl2 = @import("sdl2");

const c = @cImport({
    @cInclude("SDL2/SDL.h");
});

const WIDTH = 300;
const HEIGHT = 300;

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_EVERYTHING) != 0) {
        c.SDL_Log("error in Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    }

    const window = c.SDL_CreateWindow(
        "tata",
        c.SDL_WINDOWPOS_CENTERED,
        c.SDL_WINDOWPOS_CENTERED,
        WIDTH,
        HEIGHT,
        c.SDL_WINDOW_OPENGL | c.SDL_WINDOW_RESIZABLE,
    ) orelse {
        c.SDL_Log("error in create window %s", c.SDL_Error);
        return error.SDLWindowError;
    };
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(
        window,
        -1,
        c.SDL_RENDERER_SOFTWARE,
    ) orelse {
        c.SDL_Log("error in Render Initialization %s", c.SDL_Error);
        return error.SDLInitializationError;
    };
    defer c.SDL_DestroyRenderer(renderer);

    var event: c.SDL_Event = undefined;
    while (c.SDL_WaitEvent(&event) != 0) {
        if (event.type == c.SDL_QUIT) break;

        _ = c.SDL_SetRenderDrawColor(renderer, 255, 0, 0, c.SDL_ALPHA_OPAQUE);
        _ = c.SDL_RenderClear(renderer);
        c.SDL_RenderPresent(renderer);
    }
}

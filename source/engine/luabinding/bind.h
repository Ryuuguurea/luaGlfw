#include"lua_File.h"
#include"lua_GL.h"
#include"lua_window.h"
#include"lua_font.h"
void bind(lua_State*L){
    Lua_File::Bind(L);
    Lua_Window::Bind(L);
    Binding_GL(L);
    font_bind(L);
}
#include"lua_img.h"
#include"lua_GL.h"
#include"lua_window.h"
void bind(lua_State*L){
    Lua_Img::Bind(L);
    Lua_Window::Bind(L);
    Binding_GL(L);
}
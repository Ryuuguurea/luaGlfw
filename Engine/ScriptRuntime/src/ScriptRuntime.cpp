#include "lua.hpp"
#include"lua_File.h"
#include"lua_GL.h"
#include"lua_window.h"
#include"lua_font.h"
#include"ScriptRuntime.h"


inline int traceback(lua_State* L)
{
    std::cout<<lua_tostring(L,-1)<<std::endl;
    luaL_traceback(L, L, NULL, 1);
    std::cout<<lua_tostring(L, -1)<<std::endl;
    return 1;
}
ScriptRuntime::ScriptRuntime(const std::string& bootstrap)
{
    lua_State* L = nullptr;
    L = luaL_newstate();
    luaL_openlibs(L);
    lua_pushcfunction(L, &traceback);
    Lua_File::Bind(L);
    Lua_Window::Bind(L);
    Binding_GL(L);
    font_bind(L);
    if(luaL_loadfile(L,bootstrap.c_str())!=0){
        std::cout<<"Invalid Bootstrap File"<<lua_tostring(L, -1)<<std::endl;
        system("pause");
    }
    if (lua_pcall(L, 0, 0, -2) != 0)
    {
        std::cout<<lua_tostring(L, -1);
        system("pause");
    }

}

ScriptRuntime::~ScriptRuntime()
{
}

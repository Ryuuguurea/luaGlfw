#include "lua.hpp"
#include"lua_File.h"
#include"lua_GL.h"
#include"lua_window.h"
#include"lua_font.h"
#include"ScriptRuntime.h"


inline int traceback(lua_State* L)
{
    // look up Lua's 'debug.traceback' function
    lua_getglobal(L, "debug");
    if (!lua_istable(L, -1))
    {
        lua_pop(L, 1);
        return 1;
    }
    lua_getfield(L, -1, "traceback");
    if (!lua_isfunction(L, -1))
    {
        lua_pop(L, 2);
        return 1;
    }
    lua_pushvalue(L, 1); /* pass error message */
    lua_pushinteger(L, 2); /* skip this function and traceback */
    lua_call(L, 2, 1); /* call debug.traceback */
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
        std::cout<<lua_tostring(L, -1);
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

#include "luabinding/bind.h"
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
int main(int argc, char *argv[])
{
    if(argc>1){
        lua_State* L = nullptr;
        L = luaL_newstate();
        luaL_openlibs(L);
        lua_pushcfunction(L, &traceback);
        bind(L);
        luaL_dofile(L,argv[1]);
    }
    return 0;
}

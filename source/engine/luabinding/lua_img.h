#ifndef LUAIMG_H
#define LUAIMG_H
#include "lua/lua.hpp"
#include <string>
class Lua_Img
{
private:

public:
    int width;
    int height;
    int nrChannels;
    unsigned char*data;
    std::string path;
    static void Bind(lua_State *L);
    ~Lua_Img();
    Lua_Img(std::string path);
    Lua_Img(const Lua_Img&)=delete;
    Lua_Img&operator =(const Lua_Img&)=delete;
};

#endif
#ifndef LUAIMG_H
#define LUAIMG_H
#include "lua/lua.hpp"
#include <string>
#include<memory>
#include<LuaBridge/RefCountedObject.h>
#include<LuaBridge/RefCountedPtr.h>
struct ImageData:luabridge::RefCountedObject{
    unsigned char*data;
    int width;
    int height;
    int nrChannels;
    std::string path;
    ~ImageData();
};
class Lua_Img
{
private:

public:
    static void Bind(lua_State *L);
    static luabridge::RefCountedObjectPtr<ImageData> Load(std::string);
};

#endif
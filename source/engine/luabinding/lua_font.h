#ifndef FONT_H
#define FONT_H

#include<lua/lua.hpp>
#include<LuaBridge/LuaBridge.h>
#include<LuaBridge/RefCountedObject.h>
#include<LuaBridge/RefCountedPtr.h>
#include <ft2build.h>
#include <vector>
#include FT_FREETYPE_H
using namespace std;
using namespace luabridge;
struct FontChar:RefCountedObject{
    unsigned int textureID;
    size_t sizeX;
    size_t sizeY;
    size_t bearX;
    size_t bearY;
    size_t advance;
    ~FontChar();
    FontChar()=default;
    FontChar(const FontChar&)=delete;
    FontChar &operator=(const FontChar&)=delete;
};
struct Font:RefCountedObject{
    FT_Face face;
    string path;
    ~Font();
    Font()=default;
    Font(const Font&)=delete;
    Font &operator=(const Font&)=delete;
    RefCountedObjectPtr<FontChar> LoadChar(string);
};

void font_bind(lua_State *L);
#endif
#include"lua_font.h"
#include <glad/glad.h>

#include <codecvt>
#include <iostream>
using namespace std;
using namespace luabridge;
#ifdef WIN32
#define FONT_PATH "C:/Windows/Fonts/Arial.ttf"
#else
#define FONT_PATH "/Library/Fonts/Arial Unicode.ttf"
#endif
std::u32string to_utf32( std::string str )
{ 
    return std::wstring_convert< std::codecvt_utf8<char32_t>, char32_t >{}.from_bytes(str); 
}
RefCountedObjectPtr<FontChar> Font::LoadChar(string c){
    RefCountedObjectPtr<FontChar> object;
    u32string str32 = to_utf32(c);
    if(!FT_Load_Char(face,str32[0],FT_LOAD_RENDER)){
        glPixelStorei(GL_UNPACK_ALIGNMENT, 1); 
        object=new FontChar();
        glGenTextures(1,&object->textureID);
        glBindTexture(GL_TEXTURE_2D,object->textureID);
        glTexImage2D(
            GL_TEXTURE_2D,
            0,
            GL_RED,
            face->glyph->bitmap.width,
            face->glyph->bitmap.rows,
            0,
            GL_RED,
            GL_UNSIGNED_BYTE,
            face->glyph->bitmap.buffer
        );
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        object->advance=face->glyph->advance.x;
        object->bearX=face->glyph->bitmap_left;
        object->bearY=face->glyph->bitmap_top;
        object->sizeX=face->glyph->bitmap.width;
        object->sizeY=face->glyph->bitmap.rows;
    }
    return object;
}
FT_Library ft;
RefCountedObjectPtr<Font> LoadFont(string path){
    RefCountedObjectPtr<Font> object;
    FT_Face face;
    if (!FT_New_Face(ft, FONT_PATH, 0, &face)){
        FT_Set_Pixel_Sizes(face, 0, 48);
        object=new Font();
        object->face=face;
    }
    return object;
}
Font::~Font(){
    FT_Done_Face(face);
    cout<<"font free"<<path<<endl;
}
FontChar::~FontChar(){
    cout<<"todo free fontchar";    
}

void font_bind(lua_State *L){
    if (FT_Init_FreeType(&ft))
        std::cout << "ERROR::FREETYPE: Could not init FreeType Library" << std::endl;

    luabridge::getGlobalNamespace(L).beginClass<FontChar>("FontChar")
    .addProperty("textureID",&FontChar::textureID)
    .addProperty("sizeX",&FontChar::sizeX)
    .addProperty("sizeY",&FontChar::sizeY)
    .addProperty("bearX",&FontChar::bearX)
    .addProperty("bearY",&FontChar::bearY)
    .addProperty("advance",&FontChar::advance).endClass();

    luabridge::getGlobalNamespace(L).beginClass<Font>("Font")
    .addStaticFunction("LoadFont",LoadFont)
    .addFunction("LoadChar",&Font::LoadChar).endClass();
}
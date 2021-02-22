#include"lua_font.h"
#include <glad/glad.h>

#include <iostream>
using namespace std;
using namespace luabridge;

RefCountedObjectPtr<FontChar> Font::LoadChar(string c){
    RefCountedObjectPtr<FontChar> object;
    if(!FT_Load_Char(face,c[0],FT_LOAD_RENDER)){
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
        object->left=face->glyph->bitmap_left;
        object->top=face->glyph->bitmap_top;
        object->width=face->glyph->bitmap.width;
        object->rows=face->glyph->bitmap.rows;
    }
    return object;
}
FT_Library ft;
RefCountedObjectPtr<Font> LoadFont(string path){
    RefCountedObjectPtr<Font> object;
    FT_Face face;
    if (!FT_New_Face(ft, "/Library/Fonts/Arial Unicode.ttf", 0, &face)){
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
    luabridge::getGlobalNamespace(L).beginClass<Font>("Font")
    .addStaticFunction("LoadFont",LoadFont)
    .addFunction("LoadChar",&Font::LoadChar);

    luabridge::getGlobalNamespace(L).beginClass<FontChar>("FontChar")
    .addProperty("textureID",&FontChar::textureID)
    .addProperty("width",&FontChar::width)
    .addProperty("rows",&FontChar::rows)
    .addProperty("left",&FontChar::left)
    .addProperty("top",&FontChar::top)
    .addProperty("advance",&FontChar::advance);
}
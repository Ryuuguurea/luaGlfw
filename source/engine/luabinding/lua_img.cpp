#include "lua_img.h"
#include "stb_image.h"
#include "LuaBridge/LuaBridge.h"
using namespace std;
Lua_Img::Lua_Img(string path){
    int width, height, nrChannels;
    unsigned char *data=stbi_load(path.c_str(),&width, &height, &nrChannels, 0);
    if(data){
        this->path=path;
        this->width=width;
        this->height=height;
        this->nrChannels=nrChannels;
        this->data=data;
    }
}
Lua_Img::~Lua_Img(){
    if(data)stbi_image_free(data);
    cout<<"image free";
}

void Lua_Img::Bind(lua_State *L){
    luabridge::getGlobalNamespace(L).beginClass<Lua_Img>("Img")
    .addConstructor<void(*)(string)>()
    .endClass();
}
#include "lua_img.h"
#include "stb_image.h"
#include "LuaBridge/LuaBridge.h"
using namespace std;
luabridge::RefCountedObjectPtr<ImageData> Lua_Img::Load(string path){
    int width, height, nrChannels;
    unsigned char *img=stbi_load(path.c_str(),&width, &height, &nrChannels, 0);
    luabridge::RefCountedObjectPtr<ImageData> object;
    if(img){
        object=new ImageData(); 
        object->path=path;
        object->width=width;
        object->height=height;
        object->nrChannels=nrChannels;
        object->data=img;
    }
    return object;
}
ImageData::~ImageData(){
    if(data)stbi_image_free(data);
    cout<<"image free";
}

void Lua_Img::Bind(lua_State *L){
    luabridge::getGlobalNamespace(L).beginClass<Lua_Img>("Img")
    .addStaticFunction("Load",Load)
    .endClass();
    luabridge::getGlobalNamespace(L).beginClass<ImageData>("ImageData")
    .addProperty("width",&ImageData::width)
    .addProperty("height",&ImageData::height)
    .endClass();
}
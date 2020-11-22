#include "lua_File.h"
#include "stb_image.h"
#include "LuaBridge/LuaBridge.h"
#include <fstream>
#include<iterator>
using namespace std;
luabridge::RefCountedObjectPtr<ImageData> Lua_File::LoadImage(string path){
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
luabridge::RefCountedObjectPtr<BinaryData> Lua_File::LoadFile(string path){
    luabridge::RefCountedObjectPtr<BinaryData> object;
    ifstream in(path,ios::binary);
    if(in){ 
        in.seekg(0,ios::end);
        int length=in.tellg();
        object=new BinaryData(length);
        in.seekg(0,ios::beg);
        in.read(object->data,length);
    }
    in.close();
    return object;
}
ImageData::~ImageData(){
    if(data)stbi_image_free(data);
    cout<<"image free:"<<path<<endl;
}
BinaryData::BinaryData(int length):length(length){
    data=new char[length];
}
BinaryData::~BinaryData(){
    delete data;
    cout<<"data free"<<endl;
}
void Lua_File::Bind(lua_State *L){
    luabridge::getGlobalNamespace(L).beginClass<Lua_File>("File")
    .addStaticFunction("LoadImage",LoadImage)
    .addStaticFunction("LoadFile",LoadFile)
    .endClass();
    luabridge::getGlobalNamespace(L).beginClass<ImageData>("ImageData")
    .addProperty("width",&ImageData::width)
    .addProperty("height",&ImageData::height)
    .addProperty("channels",&ImageData::nrChannels)
    .endClass();
    luabridge::getGlobalNamespace(L).beginClass<BinaryData>("BinaryData")
    .addProperty("length",&BinaryData::length)
    .endClass();
}
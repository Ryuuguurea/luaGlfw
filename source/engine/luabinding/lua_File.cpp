#include "lua_File.h"
#include "stb_image.h"
#include "LuaBridge/LuaBridge.h"
#include<LuaBridge/Vector.h>
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
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::Slice(size_t start,size_t end){
    luabridge::RefCountedObjectPtr<BinaryData> object;
    object=new BinaryData(end-start);
    for(size_t i=start;i<end;i++){
        object->data[i-start]=data[i];
    }
    return object;
}
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::Join(std::vector<luabridge::RefCountedObjectPtr<BinaryData>> list){
    luabridge::RefCountedObjectPtr<BinaryData> object;
    size_t length;
    for(auto i:list){
        length+=i->length;
    }
    object=new BinaryData(length);
    int index=0;
    for(auto obj:list){
        for(size_t i=0;i<obj->length;i++){
            object->data[index]=obj->data[i];
            index++;
        }
    }
    return object;
}
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::FromUint8(vector<unsigned char> value){
    luabridge::RefCountedObjectPtr<BinaryData> object;
    size_t length=value.size();
    object=new BinaryData(length);
    for(size_t i=0;i<length;i++){
        object->data[i]=value[i];
    }
    return object;
}
std::vector<unsigned char> BinaryData::GetUint8(){
    std::vector<unsigned char> result;
    for(size_t i=0;i<length;i++){
        result.push_back(data[i]);
    }
    return result;
}
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::FromFloat32(std::vector<float> value){
   luabridge::RefCountedObjectPtr<BinaryData> object;
    size_t length=value.size();
    object=new BinaryData(length*4);
    for(size_t i=0;i<length;i++){
        float *ptr= (float*)&object->data[i*4];
        *ptr=value[i];
    }
    return object;
}
std::vector<float> BinaryData::GetFloat32(){
    std::vector<float> result;
    for(size_t i=0;i<length;i=i+4){
        float *ptr=(float*)&data[i];
        result.push_back(*ptr);
    }
    return result;
}
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::FromInt32(std::vector<int> value){
   luabridge::RefCountedObjectPtr<BinaryData> object;
    size_t length=value.size();
    object=new BinaryData(length*4);
    for(size_t i=0;i<length;i++){
        int *ptr= (int*)&object->data[i*4];
        *ptr=value[i];
    }
    return object;
}
std::vector<int> BinaryData::GetInt32(){
    std::vector<int> result;
    for(size_t i=0;i<length;i=i+4){
        int *ptr=(int*)&data[i];
        result.push_back(*ptr);
    }
    return result;
}
luabridge::RefCountedObjectPtr<BinaryData> BinaryData::FromUint16(std::vector<uint16_t> value){
   luabridge::RefCountedObjectPtr<BinaryData> object;
    size_t length=value.size();
    object=new BinaryData(length*4);
    for(size_t i=0;i<length;i++){
        uint16_t *ptr= (uint16_t*)&object->data[i*4];
        *ptr=value[i];
    }
    return object;
}
std::vector<uint16_t> BinaryData::GetUint16(){
    std::vector<uint16_t> result;
    for(size_t i=0;i<length;i=i+4){
        uint16_t *ptr=(uint16_t*)&data[i];
        result.push_back(*ptr);
    }
    return result;
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
    .addConstructor<void(*)(int)>()
    .addProperty("length",&BinaryData::length)
    .addStaticFunction("FromUint8",&BinaryData::FromUint8)
    .addStaticFunction("FromFloat32",&BinaryData::FromFloat32)
    .addStaticFunction("FromInt32",&BinaryData::FromInt32)
    .addStaticFunction("FromUint16",&BinaryData::FromUint16)
    .addStaticFunction("Join",&BinaryData::Join)
    .addFunction("GetUint8",&BinaryData::GetUint8)
    .addFunction("GetUint16",&BinaryData::GetUint16)
    .addFunction("GetFloat32",&BinaryData::GetFloat32)
    .addFunction("GetInt32",&BinaryData::GetInt32)
    .addFunction("Slice",&BinaryData::Slice)
    .endClass();
}
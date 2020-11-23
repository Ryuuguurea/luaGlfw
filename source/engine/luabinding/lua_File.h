#ifndef LUAFILE_H
#define LUAFILE_H
#include "lua/lua.hpp"
#include <string>
#include<memory>
#include<vector>
#include<LuaBridge/RefCountedObject.h>
#include<LuaBridge/RefCountedPtr.h>
struct ImageData:luabridge::RefCountedObject{
    unsigned char*data;
    int width;
    int height;
    int nrChannels;
    std::string path;
    ~ImageData();
    ImageData()=default;
    ImageData(const ImageData&)=delete;
    ImageData &operator=(const ImageData&)=delete;
};
struct BinaryData:luabridge::RefCountedObject{
    char* data;
    int length;
    ~BinaryData();
    BinaryData(int);
    BinaryData(const BinaryData&)=delete;
    BinaryData &operator=(const BinaryData&)=delete;
    void Set(int,unsigned char);
    unsigned char Get(int);
};

class Lua_File
{
private:

public:
    static void Bind(lua_State *L);
    static luabridge::RefCountedObjectPtr<ImageData> LoadImage(std::string);
    static luabridge::RefCountedObjectPtr<BinaryData> LoadFile(std::string);
};

#endif
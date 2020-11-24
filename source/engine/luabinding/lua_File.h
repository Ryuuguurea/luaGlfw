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
    size_t length;
    ~BinaryData();
    BinaryData(int);
    BinaryData(const BinaryData&)=delete;
    BinaryData &operator=(const BinaryData&)=delete;
    static luabridge::RefCountedObjectPtr<BinaryData> FromUint8(std::vector<unsigned char>);
    std::vector<unsigned char> GetUint8();
    static luabridge::RefCountedObjectPtr<BinaryData> FromUint16(std::vector<uint16_t>);
    std::vector<uint16_t> GetUint16();
    static luabridge::RefCountedObjectPtr<BinaryData> FromFloat32(std::vector<float>);
    std::vector<float> GetFloat32();
    static luabridge::RefCountedObjectPtr<BinaryData> FromInt32(std::vector<int>);
    std::vector<int> GetInt32();
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
#ifndef LUAFILE_H
#define LUAFILE_H

#include <string>
#include<memory>
#include<vector>
#include<lua.hpp>
#include<LuaBridge/RefCountedObject.h>
#include<LuaBridge/RefCountedPtr.h>

struct ImageData:luabridge::RefCountedObject{
    unsigned char*data;
    int width;
    int height;
    int nrChannels;
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
    luabridge::RefCountedObjectPtr<BinaryData> Slice(size_t,size_t);
    static luabridge::RefCountedObjectPtr<BinaryData> Join(std::vector<luabridge::RefCountedObjectPtr<BinaryData>>);
    static luabridge::RefCountedObjectPtr<BinaryData> FromUint8(const std::vector<unsigned char>&);
    std::vector<unsigned char> GetUint8() const;
    static luabridge::RefCountedObjectPtr<BinaryData> FromUint16(const std::vector<uint16_t>&);
    std::vector<uint16_t> GetUint16() const;
    static luabridge::RefCountedObjectPtr<BinaryData> FromFloat32(const std::vector<float>&);
    std::vector<float> GetFloat32() const;
    static luabridge::RefCountedObjectPtr<BinaryData> FromInt32(const std::vector<int>&);
    std::vector<int> GetInt32()const;

};

class Lua_File
{
private:

public:
    static void Bind(lua_State *L);
    static luabridge::RefCountedObjectPtr<ImageData> LoadImage(luabridge::RefCountedObjectPtr<BinaryData>);
    static luabridge::RefCountedObjectPtr<BinaryData> LoadFile(const std::string&);
};

#endif
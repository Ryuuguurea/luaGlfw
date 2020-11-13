#ifndef SCRIPTUTIL_H
#define SCRIPTUTIL_H
#include<lua/lua.hpp>

#include<string>
template<typename T>
class LuaObject
{
    public:
        T* ptr;
};
void Register_Enum(lua_State*L,int enumValue,char*enumValueString);


class ScriptUtil{
    public:
        template<typename T>
        static int ReturnUdata(T*ptr)
        {
            if(ptr)
            {
                LuaObject<T>*object=(LuaObject<T>*)lua_newuserdata(L,sizeof(LuaObject<T>));
                object->ptr=ptr;
                lua_setmetatable(L,-2);
            }
            return 1;
        }
        template<typename T>
        static T* CheckUdata(int index)
        {
            LuaObject<T>* luaObject=(LuaObject<T>*)luaL_checkudata(L,index,"*");
            return luaObject->ptr;
        }
        static void Register_Class(char*name,luaL_Reg*members,lua_CFunction newFunction,lua_CFunction deleteFunction,luaL_Reg*statics);
        void Run(const std::string script);
        ScriptUtil(const int argc,char* argv[]);

        static void Unref(int t,int ref);
        static lua_State *L;
    private:
        int argc;
        char **argv;
        void OpenScriptLib();
};
#endif
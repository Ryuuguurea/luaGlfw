
#include"ScriptUtil.h"
#include<iostream>
#include"lua_window.h"
#include"lua_GL.h"
lua_State* ScriptUtil::L=nullptr;

void ScriptUtil::Register_Class(char*name,luaL_Reg*members,lua_CFunction newFunction,lua_CFunction deleteFunction,luaL_Reg*statics)
{
    lua_newtable(L);
    lua_pushvalue(L,-1);
    lua_setglobal(L,name);

    lua_pushliteral(L,"metatable");
    luaL_newmetatable(L,name);
    if(members)
        luaL_setfuncs(L,members,0);
    lua_pushstring(L,"__index");
    lua_pushvalue(L,-2);
    lua_settable(L,-3);
    if(deleteFunction)
    {
        lua_pushstring(L,"__gc");
        lua_pushcfunction(L,deleteFunction);
        lua_settable(L,-3);
    }
    lua_settable(L,-3);
    if(statics)
        luaL_setfuncs(L,statics,0);
    if(newFunction)
    {
        lua_pushliteral(L,"new");
        lua_pushcfunction(L,newFunction);
        lua_settable(L,-3);
    }
}
void Register_Enum(lua_State*L,int enumValue,char*enumValueString){
    lua_pushnumber(L,enumValue);
    lua_pushvalue(L,-1);
    lua_setglobal(L,enumValueString);
}

void ScriptUtil::Unref(int t,int ref){
    luaL_unref(L,t,ref);
}
void ScriptUtil::Run(const std::string script){
    int err=luaL_dofile(this->L,script.c_str());
    if(err){
        const char * err = lua_tostring(L, -1);
        std::cout<<err<<std::endl;;
        system("pause");
    }
}
ScriptUtil::ScriptUtil(const int argc,char*argv[]):argc(argc),argv(argv){
    L=luaL_newstate();
    OpenScriptLib();
}
void ScriptUtil::OpenScriptLib()
{   
    luaL_openlibs(L);
    lua_atpanic(L, [](lua_State*l)->int{
        const char * err = lua_tostring(l, -1);
        std::cout<<err<<std::endl;
        system("pause");
        return 0;
    });
    luaL_requiref(L, "Native", [](lua_State*l)->int{
        Lua_Window::Bind();
        Binding_GL(L);
        luaL_Reg lib[]={
            {NULL,NULL}
        };
	    luaL_newlibtable(l,lib);
        return 1;
    }, 0);
	lua_settop(L, 0);
}
#ifndef LUA_WINDOW_H
#define LUA_WINDOW_H


#include<glfw/glfw3.h>
#include<lua/lua.hpp>
#include<LuaBridge/LuaBridge.h>
#include<vector>
#include<functional>
class Lua_Window{
    public:
        static int Bind(lua_State *L);
        Lua_Window(std::string name,int width,int height);
        ~Lua_Window();
        GLFWwindow*window;
        luabridge::LuaRef* frameSizeCallback;
        luabridge::LuaRef* cursorPosCallback;
        luabridge::LuaRef* scrollCallBack;
        luabridge::LuaRef* mouseButtonCallback;

    private:
        void SetFrameSizeCallback(luabridge::LuaRef*);
        void SetCursorPosCallback(luabridge::LuaRef*);
        void SetScrollCallback(luabridge::LuaRef*);
        void SetMouseButtonCallback(luabridge::LuaRef*);
        static void OnFrameSizeCallback(GLFWwindow*w,int width,int height);
        static void OnCursorPosCallback(GLFWwindow*w,double x,double y);
        static void OnScrollCallback(GLFWwindow*w,double x,double y);
        static void OnMouseButtonCallback(GLFWwindow*w,int,int,int);
        bool WindowShouldClose();
        int GetKey(int);
        void PollEvents();
        int GetTime();
        void SwapBuffers();
};
#endif
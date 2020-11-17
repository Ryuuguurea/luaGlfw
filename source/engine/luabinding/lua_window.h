#ifndef LUA_WINDOW_H
#define LUA_WINDOW_H


#include<glfw/glfw3.h>
#include<lua/lua.hpp>
#include<LuaBridge/LuaBridge.h>
#include<vector>
#include<functional>
#include<memory>
class Lua_Window{
    public:
        static int Bind(lua_State *L);
        Lua_Window(std::string name,int width,int height);
        ~Lua_Window();
        GLFWwindow*window;
        std::function<void(int,int)> frameSizeCallback;
        std::function<void(double,double)> cursorPosCallback;
        std::function<void(double,double)> scrollCallBack;
        std::function<void(int,int,int)> mouseButtonCallback;

    private:
        void SetFrameSizeCallback(luabridge::LuaRef);
        void SetCursorPosCallback(luabridge::LuaRef);
        void SetScrollCallback(luabridge::LuaRef);
        void SetMouseButtonCallback(luabridge::LuaRef);
        bool WindowShouldClose();
        int GetKey(int);
        void PollEvents();
        int GetTime();
        void SwapBuffers();
};
#endif
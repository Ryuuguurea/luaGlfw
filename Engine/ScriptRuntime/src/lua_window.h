#ifndef LUA_WINDOW_H
#define LUA_WINDOW_H


#include"lua.hpp"
#include<LuaBridge/LuaBridge.h>
#include<vector>
#include<functional>
#include<memory>

struct GLFWwindow;
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
        void SetFrameSizeCallback(const luabridge::LuaRef&);
        void SetCursorPosCallback(const luabridge::LuaRef&);
        void SetScrollCallback(const luabridge::LuaRef&);
        void SetMouseButtonCallback(const luabridge::LuaRef&);
        bool WindowShouldClose();
        int GetKey(int);
        void PollEvents();
        double GetTime();
        void SwapBuffers();
};
#endif
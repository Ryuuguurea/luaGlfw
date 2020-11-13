#ifndef LUA_WINDOW_H
#define LUA_WINDOW_H


#include<glfw/glfw3.h>
#include"ScriptUtil.h"
#include<vector>
#include<functional>
class Lua_Window{
    public:
        static int Bind();
        Lua_Window(const char *name,int width,int height);
        ~Lua_Window();
        GLFWwindow*window;
        int frameSizeCallback;
        int cursorPosCallback;
        int scrollCallBack;
        int mouseButtonCallback;

    private:
        static void OnFrameSizeCallback(GLFWwindow*w,int width,int height);
        static void OnCursorPosCallback(GLFWwindow*w,double x,double y);
        static void OnScrollCallback(GLFWwindow*w,double x,double y);
        static void OnMouseButtonCallback(GLFWwindow*w,int,int,int);

};
#endif
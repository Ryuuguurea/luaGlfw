#include<glad/glad.h>
#include"lua_window.h"
#include<LuaBridge/LuaBridge.h>

#include<GLFW/glfw3.h>

using namespace luabridge;
using namespace std;

void OnCursorPosCallback(GLFWwindow*w,double x,double y){
	Lua_Window* self=(Lua_Window*)glfwGetWindowUserPointer(w);
	self->cursorPosCallback(x,y);
}
void OnFrameSizeCallback(GLFWwindow*w,int width,int height){
	Lua_Window* self=(Lua_Window*)glfwGetWindowUserPointer(w);
	self->frameSizeCallback(width,height);
}
void OnScrollCallback(GLFWwindow*w,double x,double y){
	Lua_Window* self=(Lua_Window*)glfwGetWindowUserPointer(w);
	self->scrollCallBack(x,y);
}
void OnMouseButtonCallback(GLFWwindow*w,int a,int b,int c){
	Lua_Window* self=(Lua_Window*)glfwGetWindowUserPointer(w);
	self->mouseButtonCallback(a,b,c);
}


Lua_Window::Lua_Window(string name,int width,int height){
	glfwInit();
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	window = glfwCreateWindow(width, height, name.c_str(), NULL, NULL);
	if (window == nullptr)
	{
		printf("Failed to create GLFW window");
		glfwTerminate();
		return;
	}
	glfwMakeContextCurrent(window);
	glfwSetFramebufferSizeCallback(window, OnFrameSizeCallback);
	glfwSetCursorPosCallback(window, OnCursorPosCallback);
	glfwSetScrollCallback(window, OnScrollCallback);
	glfwSetMouseButtonCallback(window,OnMouseButtonCallback);
	// tell GLFW to capture our mouse
	glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_NORMAL);
	
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
	{
		printf("Failed to initialize GLAD");
		return;
	}
	glfwSetWindowUserPointer(window,this);
}
Lua_Window::~Lua_Window(){

}

void Lua_Window::SetCursorPosCallback(const luabridge::LuaRef &r){
	cursorPosCallback=[r](double x,double y){
		r(x,y);
	};
}
void Lua_Window::SetFrameSizeCallback(const luabridge::LuaRef &r){
	frameSizeCallback= [r](int w,int h){
		r(w,h);
	};
}
void Lua_Window::SetScrollCallback(const luabridge::LuaRef &r){
	scrollCallBack=[r](double x,double y){
		r(x,y);
	};
}
void Lua_Window::SetMouseButtonCallback(const luabridge::LuaRef &r){
	mouseButtonCallback=[r](int a,int b,int c){
		r(a,b,c);
	};
}

bool
Lua_Window::WindowShouldClose(){
    return glfwWindowShouldClose(window);
}

void Lua_Window::SwapBuffers(){
	glfwSwapBuffers(window);
}
void Lua_Window::PollEvents(){
	glfwPollEvents();
}
double Lua_Window::GetTime(){
	return glfwGetTime();
}
int Lua_Window::GetKey(int key){
	return glfwGetKey(window,key);
}
int Lua_Window::Bind(lua_State *L){
	luabridge::getGlobalNamespace(L)
	.beginClass<Lua_Window>("Window")
	.addConstructor<void(*)(string,int,int)>()
	.addFunction("WindowShouldClose",&Lua_Window::WindowShouldClose)
	.addFunction("GetKey",&Lua_Window::GetKey)
	.addFunction("PollEvents",&Lua_Window::PollEvents)
	.addFunction("GetTime",&Lua_Window::GetTime)
	.addFunction("SwapBuffers",&Lua_Window::SwapBuffers)
	.addFunction("SetFramebufferSizeCallback",&Lua_Window::SetFrameSizeCallback)
	.addFunction("SetCursorPosCallback",&Lua_Window::SetCursorPosCallback)
	.addFunction("SetScrollCallback",&Lua_Window::SetScrollCallback)
	.addFunction("SetMouseButtonCallback",&Lua_Window::SetMouseButtonCallback)
	.endClass();
	return 1;
}
#include<glad/glad.h>
#include"lua_window.h"
#include<LuaBridge/LuaBridge.h>
using namespace luabridge;
using namespace std;
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

void Lua_Window::SetCursorPosCallback(luabridge::LuaRef*){

}
void Lua_Window::SetFrameSizeCallback(luabridge::LuaRef*){

}
void Lua_Window::SetScrollCallback(luabridge::LuaRef*){

}
void Lua_Window::SetMouseButtonCallback(luabridge::LuaRef*){

}

void Lua_Window::OnCursorPosCallback(GLFWwindow*w,double x,double y){
}
void Lua_Window::OnFrameSizeCallback(GLFWwindow*w,int width,int h){

}
void Lua_Window::OnScrollCallback(GLFWwindow*w,double x,double y){

}
void Lua_Window::OnMouseButtonCallback(GLFWwindow*window,int a,int b,int c){

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
int Lua_Window::GetTime(){
	return glfwGetTime();
}
int Lua_Window::GetKey(int key){
	return glfwGetKey(window,key);
}
int Lua_Window::Bind(lua_State *L){
	std::function<int(Lua_Window* object,int value,lua_State*L)> func=[](Lua_Window* object,int value,lua_State*L)->int{
		return 0;
	};

	luabridge::getGlobalNamespace(L)
	.beginClass<Lua_Window>("Window")
	.addConstructor<void(*)(string,int,int)>()
	.addFunction("WindowShouldClose",&Lua_Window::WindowShouldClose)
	.addFunction("GetKey",&Lua_Window::GetKey)
	.addFunction("PollEvents",&Lua_Window::PollEvents)
	.addFunction("GetTime",&Lua_Window::GetTime)
	.addFunction("SwapBuffers",&Lua_Window::SwapBuffers)
	.addFunction("SetFramebufferSizeCallback",move(func))
	.endClass();
	return 1;
}
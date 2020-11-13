#include"ScriptUtil.h"
#include<glad/glad.h>
#include"lua_window.h"

Lua_Window::Lua_Window(const char*name,int width,int height){
	glfwInit();
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	window = glfwCreateWindow(width, height, name, NULL, NULL);
	if (window == NULL)
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

void Lua_Window::OnCursorPosCallback(GLFWwindow*w,double x,double y){
	 
	lua_rawgeti(ScriptUtil::L,LUA_REGISTRYINDEX,((Lua_Window*)glfwGetWindowUserPointer(w))->cursorPosCallback);
	lua_pushnumber(ScriptUtil::L,x);
	lua_pushnumber(ScriptUtil::L,y);
    lua_call(ScriptUtil::L,2,0);
}
void Lua_Window::OnFrameSizeCallback(GLFWwindow*w,int width,int h){
	lua_rawgeti(ScriptUtil::L,LUA_REGISTRYINDEX,((Lua_Window*)glfwGetWindowUserPointer(w))->frameSizeCallback);
	lua_pushinteger(ScriptUtil::L,width);
	lua_pushinteger(ScriptUtil::L,h);
    lua_call(ScriptUtil::L,2,0);
}
void Lua_Window::OnScrollCallback(GLFWwindow*w,double x,double y){
	lua_rawgeti(ScriptUtil::L,LUA_REGISTRYINDEX,((Lua_Window*)glfwGetWindowUserPointer(w))->scrollCallBack);
	lua_pushnumber(ScriptUtil::L,x);
	lua_pushnumber(ScriptUtil::L,y);
    lua_call(ScriptUtil::L,2,0);
}
void Lua_Window::OnMouseButtonCallback(GLFWwindow*window,int a,int b,int c){
lua_rawgeti(ScriptUtil::L,LUA_REGISTRYINDEX,((Lua_Window*)glfwGetWindowUserPointer(window))->mouseButtonCallback);
	lua_pushnumber(ScriptUtil::L,a);
	lua_pushnumber(ScriptUtil::L,b);
	lua_pushnumber(ScriptUtil::L,c);
    lua_call(ScriptUtil::L,3,0);
}

static int 
ctor(lua_State*L){
	const char* name=luaL_checkstring(L,2);
	int width=luaL_checkinteger(L,3);
	int height=luaL_checkinteger(L,4);
    Lua_Window *obj=new Lua_Window(name,width,height);
	int top=lua_gettop(L);
	lua_pushlightuserdata(L,obj);
	//LuaObject<Lua_Window>*object=(LuaObject<Lua_Window>*)lua_newuserdata(L,sizeof(LuaObject<Lua_Window>));
	int meta=lua_getfield(L,1,"metatable");
	lua_setmetatable(L,-2);
	return 1;
}
static int
gc(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
	delete luaObject;
	return 0;
}
static int
WindowShouldClose(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
	lua_pushboolean(L,glfwWindowShouldClose(luaObject->window));
    return 1;
}
static int
SetFramebufferSizeCallback(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
    luaObject->frameSizeCallback=luaL_ref(L,LUA_REGISTRYINDEX);
	return 1;
}
static int SetCursorPosCallback(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
    luaObject->cursorPosCallback=luaL_ref(L,LUA_REGISTRYINDEX);
	return 1;
}
static int SetScrollCallback(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
    luaObject->scrollCallBack=luaL_ref(L,LUA_REGISTRYINDEX);
    return 1;
}
static int SetMouseButtonCallback(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
    luaObject->mouseButtonCallback=luaL_ref(L,LUA_REGISTRYINDEX);
    return 1;
}

static int SwapBuffers(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
	glfwSwapBuffers(luaObject->window);
    return 0;
}
static int PollEvents(lua_State *L){
	glfwPollEvents();
    return 0;
}
static int GetTime(lua_State *L){
	double time= glfwGetTime();
	lua_pushnumber(L,time);
    return 1;
}
static int GetKey(lua_State *L){
	Lua_Window* luaObject=(Lua_Window*)lua_touserdata(L,1);
	int key=luaL_checkinteger(L,2);
	lua_pushnumber(L,glfwGetKey(luaObject->window,key));
	
	return 1;
}
int Lua_Window::Bind(){
    luaL_Reg m[] = {
        {"WindowShouldClose",WindowShouldClose},
		{"SetFramebufferSizeCallback",SetFramebufferSizeCallback},
		{"SetCursorPosCallback",SetCursorPosCallback},
		{"SetScrollCallback",SetScrollCallback},
		{"SetMouseButtonCallback",SetMouseButtonCallback},
		{"GetKey",GetKey},
		{"SwapBuffers",SwapBuffers},
        {NULL,NULL}
    };
    luaL_Reg s[]={
		{"PollEvents",PollEvents},
		{"GetTime",GetTime},
        {NULL,NULL}
    };
    ScriptUtil::Register_Class("Window",m,ctor,gc,s);
	return 1;
}
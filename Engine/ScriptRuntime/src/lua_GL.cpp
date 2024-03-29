#include "lua_GL.h"
#include <glad/glad.h>
#include<LuaBridge/LuaBridge.h>
#include<LuaBridge/Vector.h>
#include"lua_File.h"

using namespace std;
static int
CreateShader(int type)
{
    return glCreateShader(type);
}
static void
ShaderSource(int shader,int count,string s)
{
    const char *string = s.c_str();
    glShaderSource(shader, count,&string, NULL);
}
static void
CompileShader(int shader)
{
    glCompileShader(shader);
}
static int
GetShaderiv(int shader,int type)
{
    int state;
    glGetShaderiv(shader, type, &state);
    return state;
}
static string
GetShaderInfoLog(int shader)
{
    char log[1024];
    glGetShaderInfoLog(shader, 1024, NULL, log);
    return string(log);
}
static int
GetProgramiv(int shader,int type)
{
    int state;
    glGetProgramiv(shader, type, &state);
    return state;
}
static string
GetProgramInfoLog(int shader)
{
    char log[1024];
    glGetProgramInfoLog(shader, 1024, NULL, log);
    return string(log);
}
static int
CreateProgram()
{
    return glCreateProgram();
}
static void
AttachShader(int program,int shader)
{
    glAttachShader(program, shader);
}
static void
LinkProgram(int program)
{
    glLinkProgram(program);
}
static void
DeleteShader(int shader)
{
    glDeleteShader(shader);
}
static void
UseProgram(int shader)
{
    glUseProgram(shader);
}
static int
GetUniformLocation(int program,string name)
{
    return glGetUniformLocation(program, name.c_str());
}
static void
Uniform1i(int location,int v)
{
    glUniform1i(location, v);
}
static void
Uniform1f(int location,float v)
{
    glUniform1f(location, v);
}
static void
Uniform2fv(int location,vector<float> v)
{
    glUniform2fv(location, 1, &v[0]);
}
static void
Uniform3fv(int location,vector<float>v)
{
    glUniform3fv(location, 1, &v[0]);
}
static void
Uniform4fv(int location,vector<float>v)
{
    glUniform4fv(location, 1, &v[0]);
}
static void
UniformMatrix4fv(int location,vector<float>v)
{
    glUniformMatrix4fv(location, 1, GL_FALSE, &v[0]);
}

static int
GenVertexArrays()
{
    GLuint VAO;
    glGenVertexArrays(1, &VAO);
    return VAO;
}
static int
GenBuffers()
{
    GLuint VBO;
    glGenBuffers(1, &VBO);
    return VBO;
}
static void
BindVertexArray(unsigned int VAO)
{
    glBindVertexArray(VAO);
}
static void
Viewport(int x,int y,int z,int w)
{
    glViewport(x,y,z,w);
}

static void
BindBuffer(int target,unsigned int buffer)
{
    glBindBuffer(target, buffer);
}
static void
BufferData(int target,const luabridge::RefCountedObjectPtr<BinaryData>&data,int offset,int length,int usage){
    glBufferData(target, length, &(data->data[offset]), usage);
}
static void
EnableVertexAttribArray(int index)
{
    glEnableVertexAttribArray(index);
}
static void
VertexAttribPointer(int index,int size)
{
    glVertexAttribPointer(index, size, GL_FLOAT, GL_FALSE, size*sizeof(GLfloat), (void *)0);
}
static int
GenTextures(void)
{
    unsigned int id;
    glGenTextures(1, &id);
    return id;
}
static void
TexImage2D(GLenum target,GLint level,GLint format,GLsizei width,GLsizei height,GLint board,GLenum type,luabridge::RefCountedObjectPtr<ImageData> data)
{
    glTexImage2D(target, level, format, width, height, board, format, type, data->data);
}
static void
ActiveTexture(int texture)
{
    glActiveTexture(texture);
}
static void
BindTexture(int target ,int texture)
{
    glBindTexture(target, texture);

}
static void
DrawElements(int mode,int count,int type)
{
    glDrawElements(mode, count, type, 0);
}
static void
ClearColor(float r,float g,float b,float a)
{
    glClearColor(r, g, b, a);
}
static void
Clear(long bit)
{
    glClear(bit);
}
static void
DepthFunc(int func)
{
    glDepthFunc(func);
}
static void
Enable(int cap)
{
    glEnable(cap);
}
static void
Disable(int cap)
{
    glDisable(cap);
}

static void
GenerateMipmap(int target){
    glGenerateMipmap(target);
}
static void
DrawArrays(int mode,int count){
    glDrawArrays(mode,0x00,count);
}
static void
DeleteBuffers(GLuint buffer){
    glDeleteBuffers(1,&buffer);
}
static void 
BlendFunc(GLenum sfactor,GLenum dfactor){
    glBlendFunc(sfactor,dfactor);
}
static void
PolygonMode(GLenum mode){
    glPolygonMode(GL_FRONT_AND_BACK,mode);
}
int DEPTH_TEST=GL_DEPTH_TEST;
int VERTEX_SHADER=GL_VERTEX_SHADER;
int FRAGMENT_SHADER=GL_FRAGMENT_SHADER;
int COMPILE_STATUS=GL_COMPILE_STATUS;
int LINK_STATUS=GL_LINK_STATUS;
int ARRAY_BUFFER=GL_ARRAY_BUFFER;
int ELEMENT_ARRAY_BUFFER=GL_ELEMENT_ARRAY_BUFFER;
int STATIC_DRAW=GL_STATIC_DRAW;
int DYNAMIC_DRAW=GL_DYNAMIC_DRAW;
int COLOR_BUFFER_BIT=GL_COLOR_BUFFER_BIT;
int DEPTH_BUFFER_BIT=GL_DEPTH_BUFFER_BIT;
int TEXTURE_2D=GL_TEXTURE_2D;
int RGBA=GL_RGBA;
int RGB=GL_RGB;
int UNSIGNED_BYTE=GL_UNSIGNED_BYTE;
int TRIANGLES=GL_TRIANGLES;
int TEXTURE0=GL_TEXTURE0;
int CULL_FACE=GL_CULL_FACE;
int LINES=GL_LINES;
int TRIANGLE_STRIP=GL_TRIANGLE_STRIP;
int BLEND= GL_BLEND;
int ONE_MINUS_SRC_ALPHA=GL_ONE_MINUS_SRC_ALPHA;
int SRC_ALPHA=GL_SRC_ALPHA;
int LINE=GL_LINE;
int FILL=GL_FILL;
void Binding_GL(lua_State *L)
{
    luabridge::getGlobalNamespace(L).beginNamespace("GL")
    .addFunction("Viewport",Viewport)
    .addFunction("CreateShader",CreateShader)
    .addFunction("ShaderSource",ShaderSource)
    .addFunction("CompileShader",CompileShader)
    .addFunction("GetShaderiv",GetShaderiv)
    .addFunction("GetShaderInfoLog",GetShaderInfoLog)
    .addFunction("GetProgramiv",GetProgramiv)
    .addFunction("GetProgramInfoLog",GetProgramInfoLog)
    .addFunction("CreateProgram",CreateProgram)
    .addFunction("AttachShader",AttachShader)
    .addFunction("LinkProgram",LinkProgram)
    .addFunction("DeleteShader",DeleteShader)
    .addFunction("UseProgram",UseProgram)
    .addFunction("GetUniformLocation",GetUniformLocation)
    .addFunction("Uniform1i",Uniform1i)
    .addFunction("Uniform1f",Uniform1f)
    .addFunction("Uniform2fv",Uniform2fv)
    .addFunction("Uniform3fv",Uniform3fv)
    .addFunction("Uniform4fv",Uniform4fv)
    .addFunction("UniformMatrix4fv",UniformMatrix4fv)
    .addFunction("UseProgram",UseProgram)
    .addFunction("GenVertexArrays",GenVertexArrays)
    .addFunction("GenBuffers",GenBuffers)
    .addFunction("BindVertexArray",BindVertexArray)
    .addFunction("BindBuffer",BindBuffer)
    .addFunction("BufferData",BufferData)
    .addFunction("EnableVertexAttribArray",EnableVertexAttribArray)
    .addFunction("VertexAttribPointer",VertexAttribPointer)
    .addFunction("ActiveTexture",ActiveTexture)
    .addFunction("BindTexture",BindTexture)
    .addFunction("DrawElements",DrawElements)
    .addFunction("ClearColor",ClearColor)
    .addFunction("Clear",Clear)
    .addFunction("DepthFunc",DepthFunc)
    .addFunction("Enable",Enable)
    .addFunction("Disable",Disable)
    .addFunction("GenTextures",GenTextures)
    .addFunction("TexImage2D",TexImage2D)
    .addFunction("GenerateMipmap",GenerateMipmap)
    .addFunction("DrawArrays",DrawArrays)
    .addFunction("DeleteBuffers",DeleteBuffers)
    .addFunction("BlendFunc",BlendFunc)
    .addFunction("PolygonMode",PolygonMode)


    .addVariable("DEPTH_TEST",&DEPTH_TEST,false)
    .addVariable("VERTEX_SHADER",&VERTEX_SHADER,false)
    .addVariable("FRAGMENT_SHADER",&FRAGMENT_SHADER,false)
    .addVariable("COMPILE_STATUS",&COMPILE_STATUS,false)
    .addVariable("LINK_STATUS",&LINK_STATUS,false)
    .addVariable("ARRAY_BUFFER",&ARRAY_BUFFER,false)
    .addVariable("ELEMENT_ARRAY_BUFFER",&ELEMENT_ARRAY_BUFFER,false)
    .addVariable("STATIC_DRAW",&STATIC_DRAW,false)
    .addVariable("DYNAMIC_DRAW",&DYNAMIC_DRAW,false)
    .addVariable("COLOR_BUFFER_BIT",&COLOR_BUFFER_BIT,false)
    .addVariable("DEPTH_BUFFER_BIT",&DEPTH_BUFFER_BIT,false)
    .addVariable("TEXTURE_2D",&TEXTURE_2D,false)
    .addVariable("RGBA",&RGBA,false)
    .addVariable("UNSIGNED_BYTE",&UNSIGNED_BYTE,false)
    .addVariable("TRIANGLES",&TRIANGLES,false)
    .addVariable("TEXTURE0",&TEXTURE0,false)
    .addVariable("CULL_FACE",&CULL_FACE,false)
    .addVariable("LINES",&LINES,false)
    .addVariable("BLEND",&BLEND,false)
    .addVariable("ONE_MINUS_SRC_ALPHA",&ONE_MINUS_SRC_ALPHA,false)
    .addVariable("SRC_ALPHA",&SRC_ALPHA,false)
    .addVariable("LINE",&LINE,false)
    .addVariable("FILL",&FILL,false)
    .addVariable("RGB",&RGB,false)
    .addVariable("TRIANGLE_STRIP",&TRIANGLE_STRIP,false)
    
    .endNamespace();
}

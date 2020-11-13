#include "lua_GL.h"
#include <glad/glad.h>
static int
CreateShader(lua_State *L)
{
    int type = luaL_checkinteger(L, 1);
    lua_pushinteger(L, glCreateShader(type));
    return 1;
}
static int
ShaderSource(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    int count = luaL_checkinteger(L, 2);
    const char *string = luaL_checkstring(L, 3);
    glShaderSource(shader, count, &string, NULL);
    return 0;
}
static int
CompileShader(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    glCompileShader(shader);
    return 0;
}
static int
GetShaderiv(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    int type = luaL_checkinteger(L, 2);
    int state;
    glGetShaderiv(shader, type, &state);
    lua_pushboolean(L, state);
    return 1;
}
static int
GetShaderInfoLog(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    char log[1024];
    glGetShaderInfoLog(shader, 1024, NULL, log);
    lua_pushstring(L, log);
    return 1;
}
static int
GetProgramiv(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    int type = luaL_checkinteger(L, 2);
    int state;
    glGetProgramiv(shader, type, &state);
    lua_pushboolean(L, state);
    return 1;
}
static int
GetProgramInfoLog(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    char log[1024];
    glGetProgramInfoLog(shader, 1024, NULL, log);
    lua_pushstring(L, log);
    return 1;
}
static int
CreateProgram(lua_State *L)
{
    lua_pushinteger(L, glCreateProgram());
    return 1;
}
static int
AttachShader(lua_State *L)
{
    int program = luaL_checkinteger(L, 1);
    int shader = luaL_checkinteger(L, 2);
    glAttachShader(program, shader);
    return 0;
}
static int
LinkProgram(lua_State *L)
{
    int program = luaL_checkinteger(L, 1);
    glLinkProgram(program);
    return 0;
}
static int
DeleteShader(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    glDeleteShader(shader);
    return 0;
}
static int
UseProgram(lua_State *L)
{
    int shader = luaL_checkinteger(L, 1);
    glUseProgram(shader);
    return 0;
}
static int
GetUniformLocation(lua_State *L)
{
    int program = luaL_checkinteger(L, 1);
    const char *name = luaL_checkstring(L, 2);
    lua_pushinteger(L, glGetUniformLocation(program, name));
    return 1;
}
static int
Uniform1i(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    int v = luaL_checkinteger(L, 2);
    glUniform1i(location, v);
    return 0;
}
static int
Uniform1f(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    float v = luaL_checknumber(L, 2);
    glUniform1f(location, v);
    return 0;
}
static int
Uniform2fv(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    int top = lua_gettop(L);
    float v[top];
    for (int i = 0; i < top; i++)
    {
        v[i] = luaL_checknumber(L, i + 1);
    }
    glUniform2fv(location, 1, v);
    return 0;
}
static int
Uniform3fv(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    int top = lua_gettop(L);
    float v[top];
    for (int i = 0; i < top; i++)
    {
        v[i] = luaL_checknumber(L, i + 1);
    }
    glUniform3fv(location, 1, v);
    return 0;
}
static int
Uniform4fv(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    int top = lua_gettop(L);
    float v[top];
    for (int i = 0; i < top; i++)
    {
        v[i] = luaL_checknumber(L, i + 1);
    }
    glUniform4fv(location, 1, v);
    return 0;
}
static int
UniformMatrix4fv(lua_State *L)
{
    int location = luaL_checkinteger(L, 1);
    float v[luaL_len(L, 2)];
    lua_pushnil(L);
    int i = 0;
    while (lua_next(L, 2))
    {
        lua_pushvalue(L, -2);
        v[i] = luaL_checknumber(L, -2);
        i++;
        lua_pop(L, 2);
    }
    glUniformMatrix4fv(location, 1, GL_FALSE, v);
    return 0;
}

static int
GenVertexArrays(lua_State *L)
{
    GLuint VAO;
    glGenVertexArrays(1, &VAO);
    lua_pushinteger(L, VAO);
    return 1;
}
static int
GenBuffers(lua_State *L)
{
    GLuint VBO;
    glGenBuffers(1, &VBO);
    lua_pushinteger(L, VBO);
    return 1;
}
static int
BindVertexArray(lua_State *L)
{
    unsigned int VAO = luaL_checkinteger(L, 1);
    glBindVertexArray(VAO);
    return 0;
}
static int
Viewport(lua_State *L)
{
    int x=luaL_checkinteger(L,1);
    int y=luaL_checkinteger(L,2);
    int z=luaL_checkinteger(L,3);
    int w=luaL_checkinteger(L,4);
    glViewport(x,y,z,w);
    return 0;
}

static int
BindBuffer(lua_State *L)
{
    int target = luaL_checkinteger(L, 1);
    unsigned int buffer = luaL_checkinteger(L, 2);
    glBindBuffer(target, buffer);
    return 0;
}
static int
BufferData(lua_State *L)
{
    int target = luaL_checkinteger(L, 1);
    switch (target)
    {
    case GL_ARRAY_BUFFER:
    {
        float data[luaL_len(L, 2)];
        lua_pushnil(L);
        int i = 0;
        while (lua_next(L, 2))
        {
            lua_pushvalue(L, -2);
            data[i] = luaL_checknumber(L, -2);
            i++;
            lua_pop(L, 2);
        }
        int usage = luaL_checkinteger(L, 3);
        glBufferData(target, sizeof(data), data, usage);
    }
    break;
    case GL_ELEMENT_ARRAY_BUFFER:
    {
        unsigned int data[luaL_len(L, 2)];
        lua_pushnil(L);
        int i = 0;
        while (lua_next(L, 2))
        {
            lua_pushvalue(L, -2);
            data[i] = luaL_checkinteger(L, -2);
            i++;
            lua_pop(L, 2);
        }
        int usage = luaL_checkinteger(L, 3);
        glBufferData(target, sizeof(data), data, usage);
    }
    break;
    default:
        break;
    }
    return 0;
}
static int
EnableVertexAttribArray(lua_State *L)
{
    int index = luaL_checkinteger(L, 1);
    glEnableVertexAttribArray(index);
    return 0;
}
static int
VertexAttribPointer(lua_State *L)
{
    int index = luaL_checkinteger(L, 1);
    int size = luaL_checkinteger(L, 2);
    glVertexAttribPointer(index, size, GL_FLOAT, GL_FALSE, size * sizeof(float), (void *)0);
    return 0;
}
static int
GenTextures(lua_State *L)
{
    unsigned int id;
    glGenTextures(1, &id);
    lua_pushinteger(L, id);
    return 1;
}
static int
TexImage2D(lua_State *L)
{
    GLenum target = luaL_checkinteger(L, 1);
    GLint level = luaL_checkinteger(L, 2);
    GLint format = luaL_checkinteger(L, 3);
    GLsizei width = luaL_checkinteger(L, 4);
    GLsizei height = luaL_checkinteger(L, 5);
    GLint board = luaL_checkinteger(L, 6);
    GLenum type = luaL_checkinteger(L, 7);
    unsigned char *data;
    glTexImage2D(target, level, format, width, height, board, format, type, data);
}
static int
ActiveTexture(lua_State *L)
{
    int texture = luaL_checkinteger(L, 1);
    glActiveTexture(texture);
    return 0;
}
static int
BindTexture(lua_State *L)
{
    int target = luaL_checkinteger(L, 1);
    int texture = luaL_checkinteger(L, 2);
    glBindTexture(target, texture);
    return 0;
}
static int
DrawElements(lua_State *L)
{
    int mode = luaL_checkinteger(L, 1);
    int count = luaL_checkinteger(L, 2);
    glDrawElements(mode, count, GL_UNSIGNED_INT, 0);
    return 0;
}
static int
ClearColor(lua_State *L)
{
    float r = luaL_checknumber(L, 1);
    float g = luaL_checknumber(L, 2);
    float b = luaL_checknumber(L, 3);
    float a = luaL_checknumber(L, 4);
    glClearColor(r, g, b, a);
    return 0;
}
static int
Clear(lua_State *L)
{
    long bit = luaL_checkinteger(L, 1);
    glClear(bit);
    return 0;
}
static int
DepthFunc(lua_State *L)
{
    int func = luaL_checkinteger(L, 1);
    glDepthFunc(func);
    return 0;
}
static int
Enable(lua_State *L)
{
    int cap=luaL_checkinteger(L,1);
    glEnable(cap);
    return 0;
}
int Binding_GL(lua_State *L)
{
    luaL_Reg l[] = {
        {"Viewport",Viewport},

        
        {"CreateShader", CreateShader},
        {"ShaderSource", ShaderSource},
        {"CompileShader", CompileShader},
        {"GetShaderiv", GetShaderiv},
        {"GetShaderInfoLog", GetShaderInfoLog},
        {"GetProgramiv", GetProgramiv},
        {"GetProgramInfoLog", GetProgramInfoLog},
        {"CreateProgram", CreateProgram},
        {"AttachShader", AttachShader},
        {"LinkProgram", LinkProgram},
        {"DeleteShader", DeleteShader},
        {"UseProgram", UseProgram},
        {"GetUniformLocation", GetUniformLocation},
        {"Uniform1i", Uniform1i},
        {"Uniform1f", Uniform1f},
        {"Uniform2fv", Uniform2fv},
        {"Uniform3fv", Uniform3fv},
        {"Uniform4fv", Uniform4fv},
        {"UniformMatrix4fv", UniformMatrix4fv},
        {"UseProgram", UseProgram},
        {"GenVertexArrays", GenVertexArrays},
        {"GenBuffers", GenBuffers},
        {"BindVertexArray", BindVertexArray},
        {"BindBuffer", BindBuffer},
        {"BufferData", BufferData},
        {"EnableVertexAttribArray", EnableVertexAttribArray},
        {"VertexAttribPointer", VertexAttribPointer},
        {"ActiveTexture", ActiveTexture},
        {"BindTexture", BindTexture},
        {"DrawElements", DrawElements},
        {"ClearColor", ClearColor},
        {"Clear", Clear},
        {"DepthFunc", DepthFunc},
        {"Enable",Enable},
        {NULL, NULL}};
    ScriptUtil::Register_Class("GL", NULL, NULL, NULL, l);
    return 1;
}

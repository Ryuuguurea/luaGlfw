Shader=class({
    ctor=function(self,data)
        local vertexCode=data.Vert
        local fragmentCode=data.Frag 
        vertex=GL.CreateShader(GL.VERTEX_SHADER)
        GL.ShaderSource(vertex,1,vertexCode)
        GL.CompileShader(vertex)
        if not GL.GetShaderiv(vertex,GL.COMPILE_STATUS) then        
            print(GL.GetShaderInfoLog(vertex))
        end
        fragment=GL.CreateShader(GL.FRAGMENT_SHADER)
        GL.ShaderSource(fragment,1,fragmentCode)
        GL.CompileShader(fragment)
        if not GL.GetShaderiv(fragment,GL.COMPILE_STATUS) then
            print(GL.GetShaderInfoLog(fragment))
        end
    
        local ID=GL.CreateProgram()
        GL.AttachShader(ID,vertex)
        GL.AttachShader(ID,fragment)
        GL.LinkProgram(ID)
        if not GL.GetProgramiv(ID,GL.LINK_STATUS) then
            print(GL.GetProgramInfoLog(fragment))
        end
        GL.DeleteShader(fragment)
        GL.DeleteShader(vertex)
        self.program=ID
        self.pass=data.pass
        self.cull=GL[data.cull]
        if data.blend~=nil then
            self.blend={
                sfactor=GL[data.blend.sfactor],
                dfactor=GL[data.blend.dfactor]
            }
        end
    end,
    property={
        SetMat4=function(self,name,mat4)
            GL.UniformMatrix4fv(self:GetUniformLocation(name),mat4.data)
        end,
        SetFloat=function(self,name,value)
            GL.Uniform1f(self:GetUniformLocation(name),value)
        end,
        GetUniformLocation=function(self,name)
            return GL.GetUniformLocation(self.program,name)
        end,
        UseShader=function(self)
            GL.UseProgram(self.program)
        end,
        SetVector4=function(self,name,value)
            GL.Uniform4fv(self:GetUniformLocation(name),value)
        end,
        SetInt=function(self,name,value)
            GL.Uniform1i(self:GetUniformLocation(name),value)
        end
    }
})
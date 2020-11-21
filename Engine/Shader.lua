Shader=class({
    ctor=function(self,data)
        local vertexCode=data.Vert
        local fragmentCode=data.Frag 
        vertex=GL.CreateShader(GL.VERTEX_SHADER)
        GL.ShaderSource(vertex,1,vertexCode)
        GL.CompileShader(vertex)
        assert(GL.GetShaderiv(vertex,GL.COMPILE_STATUS)~=0,GL.GetShaderInfoLog(vertex))        

        fragment=GL.CreateShader(GL.FRAGMENT_SHADER)
        GL.ShaderSource(fragment,1,fragmentCode)
        GL.CompileShader(fragment)
        assert(GL.GetShaderiv(fragment,GL.COMPILE_STATUS)~=0,GL.GetShaderInfoLog(fragment))

    
        local ID=GL.CreateProgram()
        GL.AttachShader(ID,vertex)
        GL.AttachShader(ID,fragment)
        GL.LinkProgram(ID)
        assert(GL.GetProgramiv(ID,GL.LINK_STATUS)~=0,GL.GetProgramInfoLog(ID))

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
        if data.mode~=nil then
            self.mode=GL[data.mode]
        end
        self.light=data.light
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
        end,
        SetVector3=function(self,name,value)
            GL.Uniform3fv(self:GetUniformLocation(name),{value[1],value[2],value[3]})
        end
    }
})
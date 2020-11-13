require"Native"
Material=class({
    ctor=function(self,v)
        local vertexCode=v.Vert
        local fragmentCode=v.Frag 
        vertex=GL.CreateShader(0x8b31)
        GL.ShaderSource(vertex,1,vertexCode)
        GL.CompileShader(vertex)
        if not GL.GetShaderiv(vertex,0x8b81) then        
            print(GL.GetShaderInfoLog(vertex))
        end
        fragment=GL.CreateShader(0x8b30)
        GL.ShaderSource(fragment,1,fragmentCode)
        GL.CompileShader(fragment)
        if not GL.GetShaderiv(fragment,0x8b81) then
            print(GL.GetShaderInfoLog(fragment))
        end
    
        local ID=GL.CreateProgram()
        GL.AttachShader(ID,vertex)
        GL.AttachShader(ID,fragment)
        GL.LinkProgram(ID)
        if not GL.GetProgramiv(ID,0x8b82) then
            print(GL.GetProgramInfoLog(fragment))
        end
        GL.DeleteShader(fragment)
        GL.DeleteShader(vertex)
        v.program=ID
        self.shader=v
        self.wireframe=v.wireframe
    end,
    property={
        UseShader=function(self)

            GL.UseProgram(self.shader.program)
        end,
        SetMat4=function(self,name,mat4)
            GL.UniformMatrix4fv(self:GetUniformLocation(name),mat4.data)
        end,
        SetFloat=function(self,name,value)
            GL.Uniform1f(self:GetUniformLocation(name),value)
        end,
        GetUniformLocation=function(self,name)
            return GL.GetUniformLocation(self.shader.program,name)
        end
    }
})

Material=class({
    ctor=function(self,data)
        self.data=data
        self.shader=data.shader
        self.uniform={}
        self:UseShader()
        local textureIndex=0
        for i,v in pairs(data.uniform)do
            if type(v)=="string" then
                local tex=AssetManager:Load(v,"texture2d")
                GL.ActiveTexture(GL.TEXTURE0+textureIndex)
                self:SetInt(i,textureIndex)
                GL.BindTexture(GL.TEXTURE_2D,tex.id)
                GL.ActiveTexture(GL.TEXTURE0)
                textureIndex=textureIndex+1
            elseif type(v)=="table" and #v==4 then
                self:SetVector4(i,v)
            elseif type(v)=="table" and #v==3 then
                self:SetVector3(i,v)
            elseif type(v)=="number" then
                self:SetFloat(i,v)
            end
        end
        self.wireFrame=data.wireFrame
    end,
    property={
        UseShader=function(self)
            self.shader:UseShader()
        end,
        SetMat4=function(self,name,mat4)
            self.shader:SetMat4(name,mat4)
        end,
        SetFloat=function(self,name,value)
            self.shader:SetFloat(name,value)
        end,
        SetVector4=function(self,name,value)
            self.shader:SetVector4(name,value)
        end,
        GetUniformLocation=function(self,name)
            self.shader:GetUniformLocation(name)
        end,
        SetInt=function(self,name,value)
            self.shader:SetInt(name,value)
        end,
        SetVector3=function(self,name,value)
            self.shader:SetVector3(name,value)
        end
    },
    extend=Component,
    static={
        Load=function(self,path)
            local data=require(path)
            local shader=Shader:new(require(data.shader))
            return Material:new({
                uniform=data.uniform,
                shader=shader,
                wireFrame=data.wireFrame
            })
        end
    }
})

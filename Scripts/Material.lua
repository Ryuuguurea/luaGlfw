Material=class({
    ctor=function(self,data)
        self.data=data
        self.shader=data.shader
        self.uniform={}

        for i,v in pairs(data.uniform)do
            if type(v)=="string" then
                self.uniform[i]={
                    type="texture",
                    value=AssetManager:Load(v,"texture2d")
                }
            elseif type(v)=="table" and #v==4 then
                self.uniform[i]={
                    type="vector4",
                    value=v
                }
            elseif type(v)=="table" and #v==3 then
                self.uniform[i]={
                    type="vector3",
                    value=v
                }
            elseif type(v)=="number" then
                self.uniform[i]={
                    type="float",
                    value=v
                }
            end
            self:SetUniform(i,self.uniform[i].value)
        end
        self.wireFrame=data.wireFrame
    end,
    property={
        SetUniform=function(self,name,value)
            self.shader:UseShader()
            self.uniform[name].value=value
            if self.uniform[name].type=="vector4" then
                self.shader:SetVector4(name,value)
            elseif self.uniform[name].type=="vector3" then
                self.shader:SetVector3(name,value)
            elseif self.uniform[name].type=="float" then
                self.shader:SetFloat(name,value)
            end
        end,
        UpdateTexture=function(self)
            local textureIndex=0
            for i,v in pairs(self.uniform) do
                if v.type=="texture" then
                    GL.ActiveTexture(GL.TEXTURE0+textureIndex)
                    self.shader:SetInt(i,textureIndex)
                    GL.BindTexture(GL.TEXTURE_2D,v.value.id)
                    GL.ActiveTexture(GL.TEXTURE0)
                    textureIndex=textureIndex+1
                end
            end
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

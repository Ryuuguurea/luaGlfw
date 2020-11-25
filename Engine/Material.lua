Material=class({
    ctor=function(self,data)
        self.data=data
        self.shader=AssetManager:Load(data.shader,"shader")
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
            local shader=AssetManager:Load(data.shader,"shader")
        end
    }
})

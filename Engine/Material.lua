Material=class({
    ctor=function(self,data)
        self.data=data
        self.shader=AssetManager:Load(data.shader,"shader")
        self.uniform={}
        for i,v in pairs(data.uniform)do
            if type(v)=="string" then
                self.uniform[i]=AssetManager:Load(v,"texture2d")
            elseif type(v)=="table" then
                self.uniform[i]=v
            end
        end
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
        GetUniformLocation=function(self,name)
            self.shader:GetUniformLocation(name)
        end
    }
})

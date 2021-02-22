
TextRenderer=class({
    ctor=function(self,data)
        if data~=nil then
            if type(data.material)=='string'then
                self.material=AssetManager:Load(data.material,"material")
            else
                self.material=data.material
            end
            local font=Font.LoadFont()
            self.fontChar={}
            for i=1,#data.text do
                local fc=font:LoadChar(string.sub(data.text,i,i))
                table.insert(self.fontChar,fc)
            end
            self.pos=data.pos
        end
    end,
    property={
        Draw=function(self)
            for i,ch in pairs(self.fontChar) do
                
            end
        end
    },
    extend=Component

})

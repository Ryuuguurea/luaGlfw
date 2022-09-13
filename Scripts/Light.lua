Light=class({
    extend=Component,
    ctor=function(self,data)
        if data~=nil then
            self.color=data.color
        end
    end
})
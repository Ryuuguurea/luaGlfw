Actor=class({
    ctor=function(self)
        self._components={}
        self:AddComponent(Transform)
        table.insert(Scene.current.nodes,self)
    end,
    property={
        transform={
            get=function(self)
                return self:GetComponent(Transform)
            end
        },
        AddComponent=function(self,type)
            local component=type:new(self)
            self._components[type]=component
            return component
        end,
        GetComponent=function(self,type)
            return self._components[type]
        end,
        RemoveComponent=function(self,type)
            self._components[type]=nil
        end,
        Update=function(self)
            for k,v in pairs(self._components)do
                if type(v.Update)=='function'then
                    v:Update()
                end
            end
        end           
    }
})

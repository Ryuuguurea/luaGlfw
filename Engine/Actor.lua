GUUID=0
Actor=class({
    ctor=function(self,data)
        self._components={}
        if data~=nil then
            self.uuid=data.uuid
            for i,v in pairs(data.components)do
                self:AddComponent(_G[i],v)
            end
        else
            self.uuid=GUUID+1
        end
        GUUID=math.max(self.uuid,GUUID)
        SceneManager:Add(self)
    end,
    property={
        transform={
            get=function(self)
                return self:GetComponent(Transform)
            end
        },
        AddComponent=function(self,type,data)
            local component=type:new(self,data)
            self._components[type]=component
            return component
        end,
        GetComponent=function(self,type)
            return self._components[type]
        end,
        RemoveComponent=function(self,type)
            self._components[type]=nil
        end,
        Tick=function(self,delta)
            for k,v in pairs(self._components)do
                if type(v.Tick)=='function'then
                    v:Tick()
                end
            end
        end           
    }
})

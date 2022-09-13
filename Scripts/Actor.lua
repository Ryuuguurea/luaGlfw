GUUID=0
Actor=class({
    ctor=function(self,data)
        self.components={}
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
        SceneManager:SetDirty()
    end,
    property={
        transform={
            get=function(self)
                return self:GetComponent(Transform)
            end
        },
        AddComponent=function(self,type,data)
            local component=type:new(data,self)
            table.insert(self.components,component)
            SceneManager:SetDirty()
            return component
        end,
        GetComponent=function(self,type)
            for i,v in pairs(self.components)do
                if v.type==type then
                    return v
                end
            end
        end,
        GetComponents=function(self,type)
            local tb={}
            for i,v in pairs(self.components)do
                if v.type==type then
                    table.insert(tb,v)
                end
            end
            return tb
        end,
        RemoveComponent=function(self,component)
            local index=-1
            for i,v in pairs(self.components)do
                if v==component then
                    table.remove(self.components,i)
                    v:onDestroy()
                end
            end
            SceneManager:SetDirty()
        end,
        Tick=function(self,delta)
            for k,v in pairs(self.components)do
                if type(v.Tick)=='function'then
                    v:Tick(delta)
                end
            end
        end,
        onDestroy=function(self)
            for i,v in pairs(self.components)do
                v:onDestroy()
            end
            SceneManager:SetDirty()
        end           
    }
})

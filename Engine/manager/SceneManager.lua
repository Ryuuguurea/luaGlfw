SceneManager=class({
    static={
        root=nil,
        nodes={},
        Initialize=function(self,data)
            for i,v in pairs(data) do
                Actor:new(v)
            end
            for i,v in pairs(self.nodes) do
                if v.parent==nil then
                    self.root=v
                end
            end
            self.dirty=true
        end,
        Tick=function(self,delta)
            for i,v in pairs(self.nodes) do
                v:Tick()
            end
        end,
        Finalize=function(self)
        end,
        Add=function(self,actor)
            self.nodes[actor.uuid]=actor
        end,
        SetDirty=function(self)
            self.dirty=true
        end
    }
})


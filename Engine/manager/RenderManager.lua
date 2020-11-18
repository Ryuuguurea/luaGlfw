RenderManager=class({
    static={
        batches={},
        Initialize=function(self)
        end,
        Finalize=function(self)
        end,
        Tick=function(self,delta)
            for i,v in pairs(self.batches) do
                v:Tick()
            end
        end
    }
})
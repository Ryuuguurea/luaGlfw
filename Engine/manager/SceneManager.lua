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
        end
    }
})

-- function Scene:Render()
--     -- GL.ClearColor(0.1,0.2,0.1,1);
--     -- GL.Clear(0x00004000|0x00000100);

--     for i,v in pairs(self.nodes) do

--         for i,v in pairs(v._components) do
--             if v.type==Renderer then
--                 v:Render()
--             end
--         end
--     end
-- end
-- function Scene:Update()
--     for i,v in pairs(self.nodes) do
--         v:Update()
--     end
-- end
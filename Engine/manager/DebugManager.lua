DebugManager=class({
    static={
        Initialize=function(self)
            self.actor=Actor:new()
            self:DrawGrid()
            self:DrawAxis()
        end,
        Tick=function(self,delta)
        end,
        Finalize=function(self)
        end,
        DrawLine=function(self,points,color)
            self.actor:AddComponent(LineRender,{
                points=points,
                color=color
            })
        end,
        DrawAxis=function(self)
            self:DrawLine({{-1000,0,0},{1000,0,0}},{1,0,0})
            self:DrawLine({{0,-1000,0},{0,1000,0}},{0,1,0})
            self:DrawLine({{0,0,-1000},{0,0,1000}},{0,0,1})
        end,
        DrawGrid=function(self)
            local points={}
            for x=-100,100,10 do
                if x~=0 then
                    table.insert(points,{x,0,-100})
                    table.insert(points,{x,0,100})
                end
            end
            for z=-100,100,10 do
                if z~=0 then
                    table.insert(points,{-100,0,z})
                    table.insert(points,{100,0,z})
                end
            end
            self:DrawLine(points,{0.1,0.1,0.1,1})
        end
    }
})
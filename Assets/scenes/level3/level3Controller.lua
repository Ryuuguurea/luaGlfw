level3Controller=class({
    extend=Component,
    ctor=function(self,data)
        self.grid={}
    end,
    property={
        Tick=function(self,delta)
            self:HandleInput()
        end,
        CreateCube=function(self,index)
            local cube = Actor:new()
            cube:AddComponent(Transform,{
                position={index%3*2,0,index//3*2},
                rotation={0,0,0},
                scale={0.9,0.9,0.9},
            })
            cube:AddComponent(Renderer,{
                material="./Assets/materials/default",
                mesh="./Assets/meshs/Cube"
            })
            return cube
        end,
        MoveCube=function(self,dir)
            
        end,
        HandleInput=function(self)
            if Input:GetKey(87)~=0 then --w
                table.insert(self.grid,self:CreateCube(#self.grid))  
            end
        end
    }
})
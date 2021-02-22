level2Controller=class({
    ctor=function(self,data)
        self.data=data
    end,
    property={
        Tick=function(self,delta)
            if not self.isInit then
                self:Init()
            end
            for i,v in pairs(self.light)do
                v.transform.position=self.ligthPositions[i]+Vector3:new(math.sin(Time.time)*5*5,0,0)
            end
        end,
        Init=function(self)
            self.isInit=true

            self.light={}
            self.ligthPositions={}
            for i,v in pairs(self.data.light)do
                local light=SceneManager:GetActor(v)
                table.insert(self.light,light)
                table.insert(self.ligthPositions,light.transform.position)
            end
            for row=0,7 do
                for col=0,7 do
                    local m=Mesh:Load("./Assets/meshs/Icosphere")
                    local a=Actor:new()
                    local t=a:AddComponent(Transform)
                    t.position=Vector3:new((col-7/2)*3.5,(row-7/2)*3.5,0)
                    local render=a:AddComponent(Renderer,
                    {
                        material=Material:Load("./Assets/materials/pbrcolor"),
                        mesh=m
                    })
                    render.material:SetUniform("metallic",row/7)
                    render.material:SetUniform("roughness",col/7)
                    
                end
            end

        end
    },
    extend=Component
})
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
                v.transform.position=v.transform.position+Vector3:new(math.sin(Time.time)*5*5,0,0)
            end
        end,
        Init=function(self)
            self.isInit=true
            self.cube=SceneManager:GetActor(self.data.cube)
            self.light={}
            for i,v in pairs(self.data.light)do
                table.insert(self.light,SceneManager:GetActor(v))
            end

            local b=BinaryData.FromFloat32({1.1,2.2,3.3,4.4})
            local c=b:GetFloat32()
        end
    },
    extend=Component
})
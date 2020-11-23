Transform=class({
    ctor=function(self,data)
        if data~=nil then
            self.position=Vector3:new(data.position[1],data.position[2],data.position[3])
            self.localRotation=Quaternion:Euler(Vector3:new(data.rotation[1],data.rotation[2],data.rotation[3]))
            self.scale=Vector3:new(data.scale[1],data.scale[2],data.scale[3])
        else
            self.position=Vector3:new(0,0,0)
            self.localRotation=Quaternion:new()
            self.scale=Vector3:new(1,1,1)
        end
        self._parent=nil
        self.children={}
    end,
    property={
        parent={
            set=function(self,value)
                local befor= self._parent
                if befor ~=nil then
                    for k,v in pairs(befor.children)do
                        if v==self then
                            befor.children[k]=nil
                            break
                        end
                    end
                end
                self._parent=value
                table.insert(value.children,self)
            end,
            get=function(self)
                return self._parent
            end
        },
        modelMat4={
            get=function(self)
                return Mat4x4.Compose(self.position, self.localRotation, self.scale )
            end
        },
        Rotate=function(self,eulers,world)
            local eulerRot=Quaternion:Euler(eulers)
            if world~=nil and world==true then
                self.rotation=self.rotation*Quaternion:Inverse(self.rotation)*eulerRot*self.rotation
            else
                self.localRotation=self.localRotation*eulerRot
            end
        end,
        rotation={
            get=function(self)
                return self.localRotation
            end,
            set=function(self,value)
                self.localRotation=value.normalized
            end
        }
    },
    extend=Component
})

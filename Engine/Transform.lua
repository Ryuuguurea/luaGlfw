Transform=class({
    ctor=function(self)
        self.position=Vector3:new(0,0,0)
        self.localRotation=Quaternion:new()
        self.scale=Vector3:new(1,1,1)
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

EditorCamera=class{
    ctor=function(self)
        self._lastMouse={x=0,y=0}
        self._mouseLock={
            true,
            true
        }
        self._startAngle=Vector3:new()
        self._speed=1
    end,
    property={
        Tick=function(self,d)
            local delta=Vector3:new(Input.mousePosition.x-self._lastMouse.x,Input.mousePosition.y-self._lastMouse.y,0)
            self._lastMouse=Input.mousePosition
            if Input:GetMouseButton(1) then
                if self._mouseLock[1] then
                    self._mouseLock[1]=false
                    return
                end
                self._startAngle=self._startAngle-Vector3:new(delta.y*0.005,delta.x*0.005)
                self.actor.transform.localRotation=Quaternion:Euler(self._startAngle)
            else
                self._mouseLock[1]=true
            end
            if Input:GetMouseButton(2)then
                if self._mouseLock[2] then
                    self._mouseLock[2]=false
                    return
                end
                local p=self.actor.transform.rotation*Vector3:new(-delta.x*0.05,delta.y*0.05)
                self.actor.transform.position=self.actor.transform.position+self.actor.transform.rotation*Vector3:new(-delta.x*0.05,delta.y*0.05)
            else
                self._mouseLock[2]=true
            end
            if Input.mouseScroll.y~=0 and self._speed-Input.mouseScroll.y>0 then
                self._speed=self._speed-Input.mouseScroll.y
            end
            if Input:GetKey(65)~=0 then --a
                self.actor.transform.position=self.actor.transform.position-self.actor.transform.rotation*Vector3:new(Time.deltaTime*self._speed,0,0)
            end
            if Input:GetKey(68)~=0 then --d
                self.actor.transform.position=self.actor.transform.position+self.actor.transform.rotation*Vector3:new(Time.deltaTime*self._speed,0,0)
            end
            if Input:GetKey(87)~=0 then --w
                self.actor.transform.position=self.actor.transform.position-self.actor.transform.rotation*Vector3:new(0,0,Time.deltaTime*self._speed)
            end
            if Input:GetKey(83)~=0 then --s
                self.actor.transform.position=self.actor.transform.position+self.actor.transform.rotation*Vector3:new(0,0,Time.deltaTime*self._speed)
            end
        end
    },
    extend=Component
}
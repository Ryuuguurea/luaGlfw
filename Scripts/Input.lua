Input=class({
    static={
        _mousePosition=Vector3:new(),
        _mouseButton={

        },
        _mouseScroll=Vector3:new(),
        _window=nil,
        mousePosition={
            get=function(self)
                return self._mousePosition
            end
        },
        GetMouseButton=function(self,key)
            return  self._mouseButton[key]~=nil and self._mouseButton[key]~=0
        end,
        mouseScroll={
            get=function(self)
                return self._mouseScroll
            end
        },
        GetKey=function(self,key)
            return self._window:GetKey(key)
        end
    }
})

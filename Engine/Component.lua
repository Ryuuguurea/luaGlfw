Component=class({
    ctor=function(self,actor)
        self._gameObject=actor
    end,
    property={
        actor={
            get=function(self)
                return self._gameObject
            end
        }
    }
})

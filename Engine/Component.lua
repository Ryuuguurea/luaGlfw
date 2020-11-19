Component=class({
    ctor=function(self,actor)
        self._actor=actor
    end,
    property={
        actor={
            get=function(self)
                return self._actor
            end
        }
    }
})

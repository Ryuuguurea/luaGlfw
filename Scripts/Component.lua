Component=class({
    ctor=function(self,data,actor)
        self._actor=actor
    end,
    property={
        actor={
            get=function(self)
                return self._actor
            end
        },
        onDestroy=function(self)
        end
    }
})

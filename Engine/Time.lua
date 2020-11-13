Time=class({
    static={
        _lastTime=0,
        _time=0,
        time={
            get=function(self)
                return self._time
            end
        },
        deltaTime={
            get=function(self)
                return self._time-self._lastTime
            end
        },
        Update=function(self,time)
            self._lastTime=self._time
            self._time=time
        end
    }
})
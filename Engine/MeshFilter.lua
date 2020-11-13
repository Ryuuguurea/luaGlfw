MeshFilter=class({
    extend=Component,
    ctor=function(self)

    end,
    property={
        mesh={
            set=function(self,value)
                self._mesh=value
            end,
            get=function(self)
                return self._mesh
            end
        },
        Draw=function(self,mode)
            if self._mesh~=nil then
                self._mesh:Draw(mode)
            end
        end
    }

})

Renderer=class({
    ctor=function(self,data)
        if data~=nil then
            if type(data.mesh)=='string'then
                self.mesh=AssetManager:Load(data.mesh,"mesh")
            else
                self.mesh=data.mesh
            end
            if type(data.material)=='string'then
                self.material=AssetManager:Load(data.material,"material")
            else
                self.material=data.material
            end
        end
    end,
    property={
        Draw=function(self)
            self.mesh:Draw(GL.TRIANGLES)
        end
    },
    extend=Component

})

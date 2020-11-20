
Renderer=class({
    ctor=function(self,actor,data)
        self.mesh=AssetManager:Load(data.mesh,"mesh")
        self.material=AssetManager:Load(data.material,"material")
    end,
    property={
        Draw=function(self)
            self.mesh:Draw(GL.TRIANGLES)
        end
    },
    extend=Component

})


Renderer=class({
    ctor=function(self,actor,data)
        self._materials={}
        self._mesh=nil
        self.actor=actor
        self.drawMode={
            ["wireframe"]=1,
            ["TrianglesDrawMode"]=4,
            ["TriangleStripDrawMode"]=5,
            ["TriangleFanDrawMode"]=6
        }
        self.material=AssetManager:Load(data.material,"material")
    end,
    property={

        Draw=function(self)

        end
    },
    extend=Component

})

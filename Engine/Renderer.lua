
Renderer=class({
    ctor=function(self,actor)
        self._materials={}
        self.actor=actor
        self.drawMode={
            ["wireframe"]=1,
            ["TrianglesDrawMode"]=4,
            ["TriangleStripDrawMode"]=5,
            ["TriangleFanDrawMode"]=6
        }
    end,
    property={
        Render=function(self)
            for k,v in pairs(self._materials)do
                v:UseShader()
                v:SetMat4("modelView",Camera.current.viewMat4*self.actor.transform.modelMat4)
                v:SetMat4("projection",Camera.current.projectionMat4)
                v:SetFloat("time",Time.time)
                if v.wireframe then
                    self.actor:GetComponent(MeshFilter):Draw(self.drawMode["wireframe"])
                else
                    self.actor:GetComponent(MeshFilter):Draw(self.drawMode["TriangleStripDrawMode"])
                end
            end
        end,
        AddMaterial=function(self,material)
            table.insert(self._materials,material)
        end,
        Draw=function(self)

        end
    },
    extend=Component

})

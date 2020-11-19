GeometryPass=class({
    ctor=function(self)

    end,
    property={
        Draw=function(self,frame)
            local viewMat4=frame.camera.viewMat4
            local projectionMat4=frame.camera.projectionMat4
            local a=Vector3:new(1,2,3)
            for i,v in pairs(frame.geometry)do
                v.material:UseShader()
                print(projectionMat4)
                v.material:SetMat4("modelView",viewMat4*v.actor.transform.modelMat4)
                v.material:SetMat4("projection",projectionMat4)
                v.material:SetFloat("time",Time.time)
            end
        end
    }
})
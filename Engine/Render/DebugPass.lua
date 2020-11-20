DebugPass=class({
    ctor=function()
    end,
    property={
        Draw=function(self,frame)
            GL.Enable(GL.DEPTH_TEST)
            GL.Disable(GL.CULL_FACE)
            GL.Disable(GL.BLEND)
            for i,camera in pairs(frame.camera)do
                for j,render in pairs(frame.debug)do
                    local viewMat4=camera.viewMat4
                    local projectionMat4=camera.projectionMat4
                    render.material:UseShader()
                    render.material:SetMat4("modelView",viewMat4)
                    render.material:SetMat4("projection",projectionMat4)
                    for k,uniform in pairs(render.material.uniform)do
                        if uniform.type=="vector4"then
                            render.material:SetVector4(k,uniform.value)
                        end
                    end
                    render:Draw()
                end
            end
        end
    }
})
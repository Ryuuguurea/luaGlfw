GeometryPass=class({
    ctor=function(self)

    end,
    property={
        Draw=function(self,frame)
            GL.Enable(GL.DEPTH_TEST)
            for i,camera in pairs(frame.camera)do
                local blendTable={}
                GL.Disable(GL.BLEND)
                for j,render in pairs(frame.geometry)do
                    if render.material.shader.blend ==nil then
                        self:DrawGeometry(camera,render,frame)
                    else
                        table.insert(blendTable,render)
                    end
                end
                --transparent
                GL.Enable(GL.BLEND)
                table.sort(blendTable,function(a,b)
                    return (b.actor.transform.position-camera.actor.transform.position).length-(a.actor.transform.position-camera.actor.transform.position).length
                end)
                for j,render in pairs(blendTable)do
                    self:DrawGeometry(camera,render,frame)
                end
            end
        end,
        DrawGeometry=function(self,camera,render,frame)
            local viewMat4=camera.viewMat4
            local projectionMat4=camera.projectionMat4
            render.material.shader:UseShader()
            render.material.shader:SetMat4("model",render.actor.transform.modelMat4)
            render.material.shader:SetMat4("view",viewMat4)
            render.material.shader:SetMat4("projection",projectionMat4)
            if render.material.shader.light then
                render.material.shader:SetVector3("camPos",camera.actor.transform.position)
                for i,light in pairs(frame.light)do
                    render.material.shader:SetVector3("lightPositions["..i-1 .."]",light.actor.transform.position)
                    render.material.shader:SetVector3("lightColors["..i-1 .."]",light.color)
                end
            end
            render.material:UpdateTexture()
            if render.material.shader.cull then
                GL.Enable(GL.CULL_FACE)
            else
                GL.Disable(GL.CULL_FACE)
            end
            if render.material.shader.blend~=nil then
                GL.BlendFunc(render.material.shader.blend.sfactor,render.material.shader.blend.dfactor)
            end
            if render.material.wireFrame then
                GL.PolygonMode(GL.LINE)
            end
            render:Draw()
            if render.material.wireFrame then
                GL.PolygonMode(GL.FILL)
            end
        end
    }
})
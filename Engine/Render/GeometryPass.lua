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
                        self:DrawGeometry(camera,render)
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
                    self:DrawGeometry(camera,render)
                end
            end
        end,
        DrawGeometry=function(self,camera,render)
            local viewMat4=camera.viewMat4
            local projectionMat4=camera.projectionMat4
            render.material:UseShader()
            render.material:SetMat4("modelView",viewMat4*render.actor.transform.modelMat4)
            render.material:SetMat4("projection",projectionMat4)
            local textureIndex=0
            for k,uniform in pairs(render.material.uniform)do
                if uniform.type=="vector4"then
                    render.material:SetVector4(k,uniform.value)
                elseif uniform.type=="float"then
                    render.material:SetFloat(k,uniform.value)
                elseif uniform.type=="texture"then
                    GL.ActiveTexture(GL.TEXTURE0+textureIndex)
                    render.material:SetInt(k,textureIndex)
                    GL.BindTexture(GL.TEXTURE_2D,uniform.value.id)
                    GL.ActiveTexture(GL.TEXTURE0)
                    textureIndex=textureIndex+1
                end
            end
            if render.material.shader.cull then
                GL.Enable(GL.CULL_FACE)
            else
                GL.Disable(GL.CULL_FACE)
            end
            if render.material.shader.blend~=nil then
                GL.BlendFunc(render.material.shader.blend.sfactor,render.material.shader.blend.dfactor)
            end
            render:Draw()
        end
    }
})
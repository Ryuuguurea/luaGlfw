UIPass=class({
    ctor=function(self)
        
    end,
    property={
        Draw=function(self,frame)
            GL.Disable(GL.CULL_FACE)
            GL.Enable(GL.BLEND)
            GL.BlendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
            local projection=Mat4x4.Orthographic(0,GraphicManager.width,0,GraphicManager.height,0.1,1000)
            for j,render in pairs(frame.UI)do
                render.material.shader:UseShader()
                render.material.shader:SetMat4("projection",projection)
                render:Draw()
            end
        end
    }
})
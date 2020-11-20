GraphicManager=class({
    static={
        Initialize=function(self)
            self.pass={}
            self.frame={}
            self.aspect=6/4
            table.insert(self.pass,GeometryPass:new())
            table.insert(self.pass,DebugPass:new())
        end,
        Tick=function(self,delta)
            self:BeginFrame()
            for i,v in pairs(self.pass) do
                v:Draw(self.frame)
            end
            self:EndFrame()
        end,
        Finalize=function(self)
        end,

        BeginFrame=function(self)
            if SceneManager.dirty==true then
                self:RebuildFrame()
                SceneManager.dirty=false
            end
            GL.ClearColor(0,0,0,0)
            GL.Clear(GL.COLOR_BUFFER_BIT|GL.DEPTH_BUFFER_BIT)
        end,
        EndFrame=function(self)
        end,
        RebuildFrame=function(self)
            self.frame={
                geometry={},
                camera={},
                debug={}
            }
            for i,v in pairs(SceneManager.nodes)do
                for j,component in pairs(v.components)do
                    if component.type==Renderer then
                        table.insert(self.frame[component.material.shader.pass],component)
                    end
                    if component.type==Camera then
                        table.insert(self.frame.camera,component)
                    end
                    if component.type==LineRender then
                        table.insert(self.frame[component.material.shader.pass],component)
                    end
                end
            end
            print("RebuildFrame")
        end,
        Resize=function(self,w,h)
            self.aspect=w/h
            for i,camera in pairs(self.frame.camera)do
                camera.aspect=self.aspect
            end
        end
    }
})
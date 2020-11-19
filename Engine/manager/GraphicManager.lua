GraphicManager=class({
    static={
        Initialize=function(self)
            self.pass={}
            self.frame={}
            table.insert(self.pass,GeometryPass:new())
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
            GL.ClearColor(0.05,0.05,0.05,1)
            GL.Clear(GL.COLOR_BUFFER_BIT|GL.DEPTH_BUFFER_BIT)
        end,
        EndFrame=function(self)
        end,
        RebuildFrame=function(self)
            self.frame={
                geometry={},
                camera={}
            }
            for i,v in pairs(SceneManager.nodes)do
                local r= v:GetComponent(Renderer)
                if r~=nil then
                    table.insert(self.frame[r.material.shader.pass],r)
                end
                local c=v:GetComponent(Camera)
                if c~=nil then
                    table.insert(self.frame.camera,c)
                end
            end
        end
    }
})

LineRender=class({
    ctor=function(self,data)
        self.material=Material:new({
            shader=AssetManager:Load("./Assets/shaders/debug","shader"),
            uniform={
                color={1,1,1,1}
            }
        })

        local tb={}
        if data ~=nil then
            for i,v in pairs(data.points)do
                for j,m in pairs(v)do
                     table.insert(tb,m)
                end 
            end
        end
        self.points=data.points
        self.vertices=BinaryData.FromFloat32(tb)
        self.color=data.color
        self:Setup()
    end,
    property={
        Draw=function(self)
            self.material.shader:UseShader()
            self.material.shader:SetVector4("color",self.color)
            GL.BindVertexArray(self.VAO)
            GL.DrawArrays(GL.LINES,#self.points)
            GL.BindVertexArray(0)
        end,
        onDestroy=function(self)
        end,
        Setup=function(self)
            self.VAO= GL.GenVertexArrays()
            GL.BindVertexArray(self.VAO)
            self.buffer_id= GL.GenBuffers()
            GL.BindBuffer(GL.ARRAY_BUFFER,self.buffer_id)
            GL.BufferData(GL.ARRAY_BUFFER,self.vertices,0,#self.points*3*4,GL.STATIC_DRAW)
            GL.EnableVertexAttribArray(0)
            GL.VertexAttribPointer(0,3)
        end
    },
    extend=Component
})
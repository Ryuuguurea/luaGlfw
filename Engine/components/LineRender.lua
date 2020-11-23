
LineRender=class({
    ctor=function(self,data)
        self.material=Material:new({
            shader="./Assets/shaders/debug",
            uniform={
                color={1,1,1,1}
            }
        })
        self.vertices={}
        if data ~=nil then
            for i,v in pairs(data.points)do
                for j,m in pairs(v)do
                     table.insert(self.vertices,m)
                end 
            end
            self.material.uniform.color.value=data.color
        end
        self:Setup()
    end,
    property={
        Draw=function(self)
            GL.BindVertexArray(self.VAO)
            GL.DrawArrays(GL.LINES,#self.vertices)
            GL.BindVertexArray(0)
        end,
        onDestroy=function(self)
        end,
        Setup=function(self)
            self.VAO= GL.GenVertexArrays()
            GL.BindVertexArray(self.VAO)
            self.buffer_id= GL.GenBuffers()
            GL.BindBuffer(GL.ARRAY_BUFFER,self.buffer_id)
            GL.BufferDataf(GL.ARRAY_BUFFER,self.vertices,GL.STATIC_DRAW)
            GL.EnableVertexAttribArray(0)
            GL.VertexAttribPointer(0,3)
        end
    },
    extend=Component
})
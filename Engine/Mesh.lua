

Mesh=class({
    ctor=function(self,data)
        self.vertices=data.vertex
        self.indices=data.IndexArray
        self.buffers={}
        self:SetUp()
    end,
    property={
        Draw=function(self,mode)
            GL.BindVertexArray(self.VAO)
            GL.DrawElements(mode,#self.indices)
            GL.BindVertexArray(0)
        end,
        SetUp=function(self)
            self.VAO= GL.GenVertexArrays()
            -- self.VBO=GL.GenBuffers()
            -- self.EBO=GL.GenBuffers()
            GL.BindVertexArray(self.VAO)
            -- GL.BindBuffer(0x8892,self.VBO)
            -- GL.BufferDataf(0x8892,self.vertices.position,0x88e4)
            -- GL.BindBuffer(0x8893,self.EBO)
            -- GL.BufferDatai(0x8893,self.indices,0x88e4)
            -- GL.VertexAttribPointer(0,3)
            -- GL.EnableVertexAttribArray(0)
            -- GL.BindVertexArray(0)
            attrib=0
            for i,v in pairs(self.vertices) do
                buffer_id= GL.GenBuffers()
                GL.BindBuffer(0x8892,buffer_id)
                GL.BufferDataf(0x8892,v.data,0x88e4)
                GL.EnableVertexAttribArray(attrib)
                GL.VertexAttribPointer(attrib,v.format)
                table.insert(self.buffers,buffer_id)
                attrib=attrib+1
            end
            index_buffer=GL.GenBuffers()
            GL.BindBuffer(0x8893,index_buffer)
            GL.BufferDatai(0x8893,self.indices,0x88e4)
        end
    }
})
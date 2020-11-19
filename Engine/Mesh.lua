

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
            GL.BindVertexArray(self.VAO)
            attrib=0
            for i,v in pairs(self.vertices) do
                buffer_id= GL.GenBuffers()
                GL.BindBuffer(GL.ARRAY_BUFFER,buffer_id)
                GL.BufferDataf(GL.ARRAY_BUFFER,v.data,GL.STATIC_DRAW)
                GL.EnableVertexAttribArray(attrib)
                GL.VertexAttribPointer(attrib,v.format)
                table.insert(self.buffers,buffer_id)
                attrib=attrib+1
            end
            index_buffer=GL.GenBuffers()
            GL.BindBuffer(GL.ELEMENT_ARRAY_BUFFER,index_buffer)
            GL.BufferDatai(GL.ELEMENT_ARRAY_BUFFER,self.indices,GL.STATIC_DRAW)
        end
    }
})
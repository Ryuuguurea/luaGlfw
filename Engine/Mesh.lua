local typeMap={
    VEC3=3,
    VEC2=2
}

Mesh=class({
    ctor=function(self,data)
        self.buffers={}
        self.attributes=data.attributes
        self.indices=data.indices
        self:SetUp(data.buffer)
    end,
    property={
        Draw=function(self,mode)
            GL.BindVertexArray(self.VAO)
            GL.DrawElements(mode,self.indices.length,self.indices.componentType)
            GL.BindVertexArray(0)
        end,
        SetUp=function(self,buffer)
            assert(buffer~=nil)
            self.VAO= GL.GenVertexArrays()
            GL.BindVertexArray(self.VAO)
            for i,v in pairs(self.attributes) do
                local buffer_id= GL.GenBuffers()
                GL.BindBuffer(GL.ARRAY_BUFFER,buffer_id)
                GL.BufferData(GL.ARRAY_BUFFER,buffer,v.offset,v.length,GL.STATIC_DRAW)
                GL.EnableVertexAttribArray(i-1)
                GL.VertexAttribPointer(i-1,typeMap[v.type])
                table.insert(self.buffers,buffer_id)
            end
            index_buffer=GL.GenBuffers()
            GL.BindBuffer(GL.ELEMENT_ARRAY_BUFFER,index_buffer)
            GL.BufferData(GL.ELEMENT_ARRAY_BUFFER,buffer,self.indices.offset,self.indices.length,GL.STATIC_DRAW)
        end
    },
    static={
        Load=function(self,path)
            local data=require(path)
            local buffer=File.LoadFile(path..'.bin')
            assert(buffer~=nil)
            return Mesh:new({
                attributes=data.attributes,
                indices=data.indices,
                buffer=buffer
            })
        end
    }
})
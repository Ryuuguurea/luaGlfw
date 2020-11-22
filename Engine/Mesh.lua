local typeMap={
    VEC3=3,
    VEC2=2
}

Mesh=class({
    ctor=function(self,path)
        self.path=path
        local data=require(path)
        self.attributes=data.attributes
        self.indices=data.indices
        self.buffers={}
        self:SetUp()
    end,
    property={
        Draw=function(self,mode)
            GL.BindVertexArray(self.VAO)
            GL.DrawElements(mode,self.indices.length,self.indices.componentType)
            GL.BindVertexArray(0)
        end,
        SetUp=function(self)
            local buffer=File.LoadFile(self.path..'.bin')
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
    }
})
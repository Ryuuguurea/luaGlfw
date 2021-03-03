
TextRenderer=class({
    ctor=function(self,data)
        self.material=Material:new({
            shader=AssetManager:Load("./Assets/shaders/text","shader"),
            uniform={
                color={1,1,1,1}
            }
        })
        if data~=nil then
            local font=Font.LoadFont()
            self.fontChar={}
            print(#data.text)
            local len=string.utf8Len(data.text)
            for i=1,len do
                local fc=font:LoadChar(string.utf8Index(data.text,i))
                table.insert(self.fontChar,fc)
            end
            self.x=data.x
            self.y=data.y
            self.color=data.color
            self:Setup()
        end
    end,
    property={
        Draw=function(self)
            self.material:SetUniform("color",self.color)
            GL.ActiveTexture(GL.TEXTURE0)
            for i,ch in pairs(self.chs) do
                GL.BindTexture(GL.TEXTURE_2D,ch.textureID)
                GL.BindVertexArray(ch.VAO)
                GL.DrawArrays(GL.TRIANGLES,6)
            end
        end,
        Setup=function(self)
            self.chs={}
            local x=self.x
            for i,ch in pairs(self.fontChar) do
                local xpos=x+ch.bearX
                local ypos=self.y-(ch.sizeY-ch.bearY)
                local w=ch.sizeX
                local h=ch.sizeY
                local vertices={
                    xpos,ypos+h,0,0,
                    xpos,ypos,0,1,
                    xpos+w,ypos,1,1,

                    xpos,ypos+h,0,0,
                    xpos+w,ypos,1,1,
                    xpos+w,ypos+h,1,0
                }
                local buffer=BinaryData.FromFloat32(vertices)
                local VAO=GL.GenVertexArrays()
                GL.BindVertexArray(VAO)
                local VBO=GL.GenBuffers()
                GL.BindBuffer(GL.ARRAY_BUFFER,VBO)
                GL.BufferData(GL.ARRAY_BUFFER,buffer,0,6*4*4,GL.STATIC_DRAW)
                GL.EnableVertexAttribArray(0)
                GL.VertexAttribPointer(0,4)
                table.insert(self.chs,{
                    VAO=VAO,
                    VBO=VBO,
                    textureID=ch.textureID
                })
                x=x+(ch.advance>>6)
            end
        end
    },
    extend=Component

})

Texture2d=class({
    ctor=function(self,path)
        local data=Img.Load(path)
        self.id= GL.GenTextures(1)
        GL.BindTexture(GL.TEXTURE_2D,self.id)
        GL.TexImage2D(GL.TEXTURE_2D,0,GL.RGBA,data.width,data.height,0,GL.UNSIGNED_BYTE,data)
        GL.GenerateMipmap(GL.TEXTURE_2D)
    end
})
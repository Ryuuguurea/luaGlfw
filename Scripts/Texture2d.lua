Texture2d=class({
    ctor=function(self,path)
        local data=File.LoadImage(File.LoadFile(path))
        self.id= GL.GenTextures(1)
        GL.BindTexture(GL.TEXTURE_2D,self.id)
        if data.channels==3 then
            GL.TexImage2D(GL.TEXTURE_2D,0,GL.RGB,data.width,data.height,0,GL.UNSIGNED_BYTE,data)
        elseif data.channels==4 then
            GL.TexImage2D(GL.TEXTURE_2D,0,GL.RGBA,data.width,data.height,0,GL.UNSIGNED_BYTE,data)
        end
        
        GL.GenerateMipmap(GL.TEXTURE_2D)
    end
})
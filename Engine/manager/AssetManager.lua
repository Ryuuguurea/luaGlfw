AssetManager=class({
    static={
        Initialize=function(self)
            self.cache={}
        end,
        Tick=function(self,delta)
        end,
        Finalize=function(self)
        end,
        Load=function(self,path,type)
            if self.cache[path]==nil and type=="mesh"then
                self.cache[path]=Mesh:new(require(path))
            elseif self.cache[path]==nil and type=="texture2d"then
                self.cache[path]=Texture2d:new(path)
            elseif self.cache[path]==nil and type=="material"then
                self.cache[path]=Material:new(require(path))
            elseif self.cache[path]==nil and type=="shader"then
                self.cache[path]=Shader:new(require(path))
            end
            return self.cache[path]
        end
    }
})
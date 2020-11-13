
require"Native"
Scene={
    current=nil
}
function Scene:new()
    local obj={
        nodes={}
    }
    setmetatable(obj,self)
    self.__index=self
    Scene.current=obj
    return obj
end
function Scene:load(data)
    for i,v in pairs(data) do
        self.nodes[v.uuid]=Node:new(v)
    end
    for i,v in pairs(self.nodes) do
        if type(v.parent)=="string" and self.nodes[v.parent]~=nil then
            v.parent=self.nodes[v.parent]
        end
    end
end
function Scene:Render()
    GL.ClearColor(0.1,0.2,0.1,1);
    GL.Clear(0x00004000|0x00000100);

    for i,v in pairs(self.nodes) do

        for i,v in pairs(v._components) do
            if v.type==Renderer then
                v:Render()
            end
        end
    end
end
function Scene:Update()
    for i,v in pairs(self.nodes) do
        v:Update()
    end
end
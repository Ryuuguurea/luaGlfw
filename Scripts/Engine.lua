
function class(defination)
    local cls={}
    local clsMeta={}
    local clsSet={}
    local clsGet={}
    setmetatable(cls,clsMeta)

    --ctor
    cls.new=function(self,...)
        local objMeta={}
        local objGet={}
        local objSet={}
        objMeta.__newindex=function(self,key,value)
            if objSet[key]~=nil then
                objSet[key](self,value)
            else
                if self.super ~=nil and self.super[key] then
                    self.super[key]=value
                else
                    rawset(self,key,value)
                end
            end
        end
        objMeta.__index=function(self,key)
            if objGet[key]~=nil then
                return objGet[key](self)
            else
                local super=rawget(self,'super')
                if super ~=nil then
                    return super[key]
                else
                    return rawget(self,key)
                end
            end
        end
        local instance ={type=cls}
        if defination.property~=nil then
            for k,v in pairs(defination.property)do
                if type(v)=='table' and (type(v.get)=='function' or  type(v.set)=='function')  then
                    objGet[k]=v.get
                    objSet[k]=v.set
                else
                    instance[k]=v
                end
            end
        end
        if defination.extend~=nil then
            instance.super=defination.extend:new(...)
        end
        if defination.operator~=nil then
            for k,v in pairs(defination.operator)do
                objMeta[k]=v
            end
        end

        setmetatable(instance,objMeta)
        if defination.ctor~=nil then
            defination.ctor(instance,...)
        end
        return instance
    end
    --class extend
    if defination.extend~=nil then
        setmetatable(clsMeta,defination.extend)
    end
    --static
    if defination.static~=nil then
        for k,v in pairs(defination.static) do
            if type(v)=='table' and (type(v.get)=='function' or  type(v.set)=='function')  then
                clsGet[k]=v.get
                clsSet[k]=v.set
            else
                cls[k]=v
            end
        end
    end
    clsMeta.__newindex=function (self,key,value)
        if clsSet[key]~=nil then
            clsSet[key](self,value)
        else
            rawset(self,key,value)
        end
    end
    clsMeta.__index=function(self,key)
        if clsGet[key]~=nil then
            return clsGet[key](self)
        else
            return rawget(self,key)
        end
    end
    return cls
end
Object=class({
    ctor=function(self)

    end,
    static={

    },
    property={
        toString=function()
            return "Object"
        end
    },
    operator={

    }
})

require"LinearMath"
require"Actor"
require"Component"
require"Transform"
require"Renderer"
require"Camera"
require"Shader"
require"Material"
require"Mesh"
require"Time"
require"Input"
require"Texture2d"
require"Light"

require"manager/GraphicManager"
require"manager/SceneManager"
require"manager/AssetManager"
require"manager/DebugManager"
require"Render/GeometryPass"
require"Render/DebugPass"
require"Render/UIPass"
require"components/EditorCamera"
require"components/LineRender"
require"TextRenderer"
require"UTF-8"
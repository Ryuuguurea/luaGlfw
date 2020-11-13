local AssetsMap=require"./Assets/AssetsMap"
Assets={}
local map={}
function Assets.Load(data)
    if type(data)=='string' then
        if map[data] == nil then
            map[data]= require("./Assets/"..AssetsMap[data])
        end
        return map[data]
    else
        return data
    end
end
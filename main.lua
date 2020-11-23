package.path=package.path ..";Engine/?.lua"
require"Engine/Game"
local window=Window("WINDOW",600,400)
window:SetFramebufferSizeCallback(function(w,h)
    GL.Viewport(0,0,w,h)
    GraphicManager:Resize(w,h)
end)
window:SetCursorPosCallback(function(x,y)
    Input._mousePosition=Vector3:new(x,y)
end)
window:SetScrollCallback(function(x,y)
    Input._mouseScroll=Vector3:new(x,y)
end)
window:SetMouseButtonCallback(function(a,b,c)
    Input._mouseButton[a]=b
end)
Input._window=window

_G.print_t=function(root)
    local cache = {  [root] = "." }
    local function _dump(t,space,name)
        local temp = {}
        for k,v in pairs(t) do
            local key = tostring(k)
            if cache[v] then
                table.insert(temp,"+" .. key .. " {" .. cache[v].."}")
            elseif type(v) == "table" then
                local new_key = name .. "." .. key
                cache[v] = new_key
                table.insert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. 
                    string.rep(" ",#key),new_key))
            else
                table.insert(temp,"+" .. key .. " [" .. tostring(v).."]")
            end
        end
        return table.concat(temp,"\n"..space)
    end
    print(_dump(root, "",""))
end


Game:Initialize()
mainLoop=function()
    Time:Update(window:GetTime())
    Game:Tick(Time.deltaTime)
    window:SwapBuffers()
    Input._mouseScroll=Vector3:new()
    window:PollEvents()
end
while not window:WindowShouldClose() do
    mainLoop()
end
Game:Finalize()
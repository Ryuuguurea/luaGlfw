package.path=package.path ..";Engine/?.lua"
local window=Window("WINDOW",600,400)
local game= require"Engine/Game"
game.Resize(600,400)

window:SetFramebufferSizeCallback(function(...)
    game.Resize(...)
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
game.Start()
mainLoop=function()
    Time:Update(window:GetTime())
    game.Update(Time.deltaTime)
    window:SwapBuffers()
    Input._mouseScroll=Vector3:new()
    window:PollEvents()
end
while not window:WindowShouldClose() do
    mainLoop()
end
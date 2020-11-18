package.path=package.path ..";Engine/?.lua"
require"Engine/Game"
local window=Window("WINDOW",600,400)
window:SetFramebufferSizeCallback(function(w,h)
	GL.Viewport(0,0,w,h)
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
Game:Initialize()
mainLoop=function()
    Time:Update(window:GetTime())
    Game.Tick(Time.deltaTime)
    window:SwapBuffers()
    Input._mouseScroll=Vector3:new()
    window:PollEvents()
end
while not window:WindowShouldClose() do
    mainLoop()
end
Game:Finalize()
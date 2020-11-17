require"Engine"
local Behavior={}
local scene=Scene:new()
-- local ms=require("Assets/mScene")
local a=Actor:new()
local b=Actor:new()
local cameraObj=Actor:new()
local camera=cameraObj:AddComponent(Camera)
cameraObj:AddComponent(EditorCamera)
local meshShader=require"./Assets/shaders/default"
local meshMaterial=Material:new(meshShader)
function Behavior.Start()
	-- scene:load(ms)

	material=Material:new(meshShader)
	GL.Enable(0x0B71)
	cameraObj.transform.position=Vector3:new(0,0,10)
	aRender=a:AddComponent(Renderer)
	aRender:AddMaterial(material)
	aMeshF=a:AddComponent(MeshFilter)
	aMeshF.mesh=Mesh:new(require("./Assets/meshs/cube"))

end

function Behavior.Update(dt)

	scene:Update()
	scene:Render()
end
function Behavior.Resize(w,h)
	camera.aspect=w/h
	GL.Viewport(0,0,w,h)
end


return Behavior

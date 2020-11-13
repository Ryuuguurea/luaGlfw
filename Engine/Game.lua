require"Engine"
local Behavior={}
local scene=Scene:new()
-- local ms=require("Assets/mScene")
local a=Actor:new()
local b=Actor:new()
local cameraObj=Actor:new()
local camera=cameraObj:AddComponent(Camera)
cameraObj:AddComponent(EditorCamera)
local meshShader=require"./Assets/shaders/meshStandard"
local meshMaterial=Material:new(meshShader)
function Behavior.Start()
	-- scene:load(ms)
	shader=require"./Assets/shaders/default"
	material=Material:new(shader)
	GL.Enable(0x0B71)
	cameraObj.transform.position=Vector3:new(0,0,10)
	aRender=a:AddComponent(Renderer)
	aRender:AddMaterial(material)
	aMeshF=a:AddComponent(MeshFilter)
	aMeshF.mesh=Mesh:Sphere(1,20,20)

	bRender=b:AddComponent(Renderer)
	bRender:AddMaterial(meshMaterial)
	bMeshF=b:AddComponent(MeshFilter)
	bMeshF.mesh=Mesh.cube
	a.transform:Rotate(Vector3:new(1,0,0),true)
	a.transform:Rotate(Vector3:new(0,1,0),true)
	a.transform:Rotate(Vector3:new(0,0,1),true)
	b.transform.position=Vector3:new(0,1,0)
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

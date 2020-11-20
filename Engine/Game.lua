require"Engine"
Game=class({
	static={
		Initialize=function(self)
			AssetManager:Initialize()
			GraphicManager:Initialize()
			SceneManager:Initialize(require("./Assets/mScene"))
			DebugManager:Initialize()
		end,
		Tick=function(self,delta)
			AssetManager:Tick(delta)
			SceneManager:Tick(delta)
			GraphicManager:Tick(delta)
			DebugManager:Tick(delta)
		end,
		Finalize=function(self)
			AssetManager:Finalize()
			SceneManager:Finalize()
			GraphicManager:Finalize()
			DebugManager:Finalize()
		end
	}
})

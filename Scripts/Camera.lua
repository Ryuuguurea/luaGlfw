Camera=class({
    extend=Component,
    ctor=function(self)
        Camera.current=self
        self.fov=50
        self.zoom=1
        self.near=0.1
        self.far=1000
        self.focus=10
        self.aspect=GraphicManager.width/GraphicManager.height
        self.view=nil
        self.filmGauge=35
        self.filmOffset=0
    end,
    property={
        viewMat4={
            get=function(self)
                local transform=self.actor.transform
                return transform.modelMat4.inverse
            end
        },
        projectionMat4={
            get=function(self)
                local near=self.near
                local top=near*math.tan(0.5*self.fov*math.pi / 180)
                local height=2*top
                local width=self.aspect*height
                local left=-0.5*width
                return Mat4x4.Perspective( left, left + width, top, top - height, near, self.far )
            end
        }
    }
})
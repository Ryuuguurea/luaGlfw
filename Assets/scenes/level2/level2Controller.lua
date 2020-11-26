level2Controller=class({
    ctor=function(self,data)
        self.data=data
    end,
    property={
        Tick=function(self,delta)
            if not self.isInit then
                self:Init()
            end
            for i,v in pairs(self.light)do
                v.transform.position=v.transform.position+Vector3:new(math.sin(Time.time)*5*5,0,0)
            end
        end,
        Init=function(self)
            self.isInit=true
            self.cube=SceneManager:GetActor(self.data.cube)
            self.light={}
            for i,v in pairs(self.data.light)do
                table.insert(self.light,SceneManager:GetActor(v))
            end

            local m=Mesh:new(self:sphereMesh(64,64))
            local a=Actor:new()
            a:AddComponent(Transform)
            local render=a:AddComponent(Renderer,
            {
                material="./Assets/materials/pbrcolor",
                mesh=m
            })
        end,
        sphereMesh=function(self,X_SEGMENTS,Y_SEGMENTS)
            local PI = 3.14159265359;
            local positions={}
            local uv={}
            local normals={}
            local indices={}
            for y=0,Y_SEGMENTS-1 do
                for x=0,X_SEGMENTS-1 do
                    local xSegment=x/X_SEGMENTS
                    local ySegment=y/Y_SEGMENTS
                    local xPos=math.cos(xSegment*2*PI)*math.sin(ySegment*PI)
                    local yPos=math.cos(ySegment*PI)
                    local zPos=math.sin(xSegment*2*PI)*math.sin(ySegment*PI)
                    table.insert(positions,{xPos,yPos,zPos})
                    table.insert(uv,{xSegment,ySegment})
                    table.insert(normals,{xPos,yPos,zPos})
                end
            end
            local oddRow=false
            for y=0,Y_SEGMENTS-1 do
                if not oddRow then
                    for x=0,X_SEGMENTS do
                        table.insert(indices,y*(X_SEGMENTS+1)+x)
                        table.insert(indices,(y+1)*(X_SEGMENTS+1)+x)
                    end
                else
                    for x=X_SEGMENTS,0,-1 do
                        table.insert(indices,(y+1)*(X_SEGMENTS+1)+x)
                        table.insert(indices,y*(X_SEGMENTS+1)+x)
                    end
                end
                oddRow=not oddRow
            end
            local data={}

            for i,v in pairs(positions) do
                table.insert(data,v[1])
                table.insert(data,v[2])
                table.insert(data,v[3])
            end
            for i,v in pairs(normals) do
                table.insert(data,v[1])
                table.insert(data,v[2])
                table.insert(data,v[3])
            end

            for i,v in pairs(uv) do
                table.insert(data,v[1])
                table.insert(data,v[2])
            end

            return {
                indices={
                    componentType= 5123,
                    type= "SCALAR",
                    offset= #positions*3*4+#normals*3*4+#uv*2*4,
                    length= #indices*2
                },
                attributes={
                    {
                        componentType= 5126,
                        name= "POSITION",
                        type= "VEC3",
                        offset= 0,
                        length= #positions*3*4
                    },
                    {
                        componentType= 5126,
                        name= "NORMAL",
                        type= "VEC3",
                        offset= #positions*3*4,
                        length= #normals*3*4
                    },
                    {
                        componentType= 5126,
                        name= "TEXCOORD_0",
                        type= "VEC2",
                        offset= #positions*3*4+#normals*3*4,
                        length= #uv*2*4
                    }
                },
                buffer=BinaryData.Join({BinaryData.FromFloat32(data),BinaryData.FromUint16(indices)})
            }
        end
    },
    extend=Component
})
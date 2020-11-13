

Mesh=class({
    ctor=function(self,vertices,indices)
        self.vertices=vertices
        self.indices=indices
        self:SetUp()
    end,
    property={
        Draw=function(self,mode)
            GL.BindVertexArray(self.VAO)
            GL.DrawElements(mode,#self.indices)
            GL.BindVertexArray(0)
        end,
        SetUp=function(self)
            self.VAO= GL.GenVertexArrays()
            self.VBO=GL.GenBuffers()
            self.EBO=GL.GenBuffers()
            GL.BindVertexArray(self.VAO)
            GL.BindBuffer(0x8892,self.VBO)
            GL.BufferData(0x8892,self.vertices,0x88e4)
            GL.BindBuffer(0x8893,self.EBO)
            GL.BufferData(0x8893,self.indices,0x88e4)
            GL.VertexAttribPointer(0,3)
            GL.EnableVertexAttribArray(0)

            GL.BindVertexArray(0)
        end
    },
    static={
        cube={
            get=function(self)
                local vertices={
                    0.5, -0.5, 0.5,
                    -0.5, -0.5, 0.5,
                    0.5, 0.5, 0.5,
                    -0.5, 0.5, 0.5,
                    0.5, 0.5, -0.5,
                    -0.5, 0.5, -0.5,
                    0.5, -0.5, -0.5,
                    -0.5, -0.5, -0.5,
                    0.5, 0.5, 0.5,
                    -0.5, 0.5, 0.5,
                    0.5, 0.5, -0.5,
                    -0.5, 0.5, -0.5,
                    0.5, -0.5, -0.5,
                    0.5, -0.5, 0.5,
                    -0.5, -0.5, 0.5,
                    -0.5, -0.5, -0.5,
                    -0.5, -0.5, 0.5,
                    -0.5, 0.5, 0.5,
                    -0.5, 0.5, -0.5,
                    -0.5, -0.5, -0.5,
                    0.5, -0.5, -0.5,
                    0.5, 0.5, -0.5,
                    0.5, 0.5, 0.5,
                    0.5, -0.5, 0.5
                    }
                local indices={
                    0, 2, 3,
                    0, 3, 1,
                    8, 4, 5,
                    8, 5, 9,
                    10, 6, 7,
                    10, 7, 11,
                    12, 13, 14,
                    12, 14, 15,
                    16, 17, 18,
                    16, 18, 19,
                    20, 21, 22,
                    20, 22, 23
                }
                return Mesh:new(vertices,indices)
            end
        },
        Sphere=function(self, radius, widthSegments, heightSegments, phiStart, phiLength, thetaStart, thetaLength )
            radius = radius or 1

            widthSegments = math.max( 3, math.floor( widthSegments ) or 8 )
            heightSegments = math.max( 2, math.floor( heightSegments ) or 6 )
        
            phiStart = phiStart ~= undefined and phiStart or 0
            phiLength = phiLength ~= undefined and phiLength or math.pi * 2
        
            thetaStart = thetaStart ~= undefined and thetaStart or 0
            thetaLength = thetaLength ~= undefined and thetaLength or math.pi
        
            local thetaEnd = math.min( thetaStart + thetaLength, math.pi )
        
            local ix, iy=0,0
        
            local index = 0;
            local grid = {}
        
            local vertex = Vector3:new();
            local normal = Vector3:new();
        
            
        
            local indices = {}
            local vertices = {}
            local normals = {}
            local uvs = {}
        

        
            for  iy = 0,  heightSegments do
        
                local verticesRow = {}
        
                local v = iy / heightSegments
        

        
                local uOffset = 0
        
                if ( iy == 0 and thetaStart == 0 ) then
        
                    uOffset = 0.5 / widthSegments
        
                elseif ( iy == heightSegments and thetaEnd == math.pi ) then
        
                    uOffset = - 0.5 / widthSegments
        
                end
        
                for  ix = 0, widthSegments  do
        
                    local u = ix / widthSegments
        

        
                    vertex.x = - radius * math.cos( phiStart + u * phiLength ) * math.sin( thetaStart + v * thetaLength )
                    vertex.y = radius * math.cos( thetaStart + v * thetaLength )
                    vertex.z = radius * math.sin( phiStart + u * phiLength ) * math.sin( thetaStart + v * thetaLength )
        

                    table.insert(vertices,vertex.x)
                    table.insert(vertices,vertex.y)
                    table.insert(vertices,vertex.z)
        
                    -- normal.copy( vertex ).normalize();
                    normal=vertex.normalized

                    table.insert(normals,normal.x)
                    table.insert(normals,normal.y)
                    table.insert(normals,normal.z)
        

                    table.insert(uvs,u + uOffset)
                    table.insert(uvs,1 - v)
                    
                    table.insert(verticesRow,index)
                    index=index+1
                    ix=ix +1
                end
                table.insert(grid,verticesRow )

                iy =iy+1
            end
        

        
            for  iy = 1, heightSegments  do
        
                for  ix = 1, widthSegments  do
        
                    local a = grid[ iy ][ ix + 1 ]
                    local b = grid[ iy ][ ix ]
                    local c = grid[ iy + 1 ][ ix ]
                    local d = grid[ iy + 1 ][ ix + 1 ]
        
                    if ( iy ~= 1 or thetaStart > 0 ) then

                        table.insert(indices,a)
                        table.insert(indices,b)
                        table.insert(indices,d)
                    end
                    if ( iy ~= heightSegments+1  or thetaEnd < math.pi ) then
                        table.insert(indices,b)
                        table.insert(indices,c)
                        table.insert(indices,d)
                    end
                    ix =ix+1
                end
                iy= iy+1
            end
            
            return Mesh:new(vertices,indices)

        end,
        Tetrahedron=function(self,radius,detail)
            local vertices={
                1,1,1,
                -1,-1,1,
                -1,1,-1,
                1,-1,-1
            }
            local indices={
                2,1,0,
                0,3,2,
                1,3,0,
                2,3,1
            }
            local vertexBuffer={}
            local uvBuffer={}
            subdivide(detail)
            appplyRadius(radius)
            subdivide=function(detail)
                local a=Vector3:new()
                local b=Vector3:new()
                local c=Vector3:new()
                for i=0,indices do
                    getVertexByIndex(indices[i+0],a)
                    getVertexByIndex(indices[i+1],b)
                    getVertexByIndex(indices[i+2],c)
                    subdivideFace(a,b,c,detail)
                end
            end
            local getVertexByIndex=function(index,vertex)
                local stride=index*3
                vertex.x = vertices[ stride + 0 ];
                vertex.y = vertices[ stride + 1 ];
                vertex.z = vertices[ stride + 2 ];
            end
            local subdivideFace=function(a,b,c,detail)
                local cols=math.pow(2,detail)
                local v={}
                local i,j=0,0
                for i=0,cols do
                    v[i]={}
                    local aj=Vector3:Lerp(a,c,i/cols)
                    local bj=Vector3:Lerp(b,c,i/cols)
                    local rows=cols
                    for j=0,rows do
                        if j==0 and i==cols then
                            v[i][j]=aj
                        else
                            v[i][j]=Vector3:Lerp(aj,bj,j/rows)
                        end
                    end
                end
                for i=0,cols do
                    for j=0,2*(cols-i)-1 do
                        local k=math.floor(j/2)
                        if j%2==0 then
                            pushVertex(v[i][k+1])
                            pushVertex(v[i+1][k])
                            pushVertex(v[i][k])
                        else
                            pushVertex(v[i][k+1])
                            pushVertex(v[i+1][k+1])
                            pushVertex(v[i+1][k])
                        end
                    end
                end
            end
            local pushVertex=function(vertex)
                table.insert(vertexBuffer,vertex.x)
                table.insert(vertexBuffer,vertex.y)
                table.insert(vertexBuffer,vertex.z)
            end
            local appplyRadius=function(radius)
                local vertex=Vector3:new()
                for i=0,#vertexBuffer do
                    vertex.x=vertexBuffer[i+0]
                    vertex.y=vertexBuffer[i+1]
                    vertex.z=vertexBuffer[i+2]
                    vertex=vertex.normalized*radius
                    vertexBuffer[i+0]=vertex.x
                    vertexBuffer[i+1]=vertex.y
                    vertexBuffer[i+2]=vertex.z
                end
            end
            return Mesh:new(vertices,indices)
        end
    }
})
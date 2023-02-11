require"./Assets/scenes/level3/level3Controller"
return{
    {
        name="root",
        uuid=0,
        components=
        {
            Transform={
                position={0,0,0},
                rotation={0,0,0},
                scale={1,1,1},
            },
            level3Controller={}
        }
    },
    {
        name="Main Camera",
        uuid=1,
        parent=0,
        components={
            Camera=
            {
                
            },
            Transform={
                position={0,50,0},
                rotation={-1.5707963,0,0},
                scale={1,1,1},
            },
            TextRenderer={
                text="This is a Sample",
                x=25,
                y=25,
                color={0.5,0.8,0.2,1},
                size=48
            }
        }
    },
    {
        name="plane",
        uuid=4,
        parent=0,
        components={
            Renderer=
            {
                material="./Assets/materials/plane",
                mesh="./Assets/meshs/Plane"
            },
            Transform={
                position={0,0,0},
                rotation={0,0,0},
                scale={10,10,10},
            }
        }
    }
}
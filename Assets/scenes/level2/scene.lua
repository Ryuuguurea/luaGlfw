require"./Assets/scenes/level2/level2Controller"
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
            level2Controller={
                light={5,6,7,8}
            }
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
                position={0,0,10},
                rotation={0,0,0},
                scale={1,1,1},
            },
            EditorCamera={

            }
        }
    },
    {
        name="point light",
        uuid=5,
        parent=0,
        components={
            Transform={
                position={-10,10,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={300,300,300,1}
            }
        }
    },
    {
        name="point light",
        uuid=6,
        parent=0,
        components={
            Transform={
                position={10,10,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={300,300,300,1}
            }
        }
    },
    {
        name="point light",
        uuid=7,
        parent=0,
        components={
            Transform={
                position={-10,-10,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={300,300,300,1}
            }
        }
    },
    {
        name="point light",
        uuid=8,
        parent=0,
        components={
            Transform={
                position={10,-10,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={300,300,300,1}
            }
        }
    }
}
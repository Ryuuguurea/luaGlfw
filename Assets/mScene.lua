return {
    {
        name="root",
        uuid=0,
        components=
        {
            Transform={
                position={0,0,0},
                rotation={0,0,0,0},
                scale={1,1,1},
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
                rotation={0,0,0,0},
                scale={1,1,1},
            },
            EditorCamera={

            }
        }
    },
    {
        name="Cube",
        uuid=2,
        parent=0,
        components={
            Renderer=
            {
                material="./Assets/materials/default",
                mesh="./Assets/meshs/Cube"
            },
            Transform={
                position={0,0,0},
                rotation={0,0,0,0},
                scale={1,1,1},
            }
        }
    },
    {
        name="quad",
        uuid=3,
        parent=0,
        components={
            Renderer=
            {
                material="./Assets/materials/blend",
                mesh="./Assets/meshs/Plane"
            },
            Transform={
                position={2,0,0},
                rotation={0,0,0,0},
                scale={1,1,1},
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
                position={0,-1,0},
                rotation={0,0,0,0},
                scale={10,10,10},
            }
        }
    },
    {
        name="point light",
        uuid=5,
        parent=0,
        components={
            Transform={
                position={0,0,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={1,0,0,1}
            }
        }
    },
    {
        name="point light",
        uuid=6,
        parent=0,
        components={
            Transform={
                position={0,0,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={1,0,0,1}
            }
        }
    },
    {
        name="point light",
        uuid=7,
        parent=0,
        components={
            Transform={
                position={0,0,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={1,0,0,1}
            }
        }
    },
    {
        name="point light",
        uuid=8,
        parent=0,
        components={
            Transform={
                position={0,0,10},
                rotation={0,0,0},
                scale={1,1,1}
            },
            Light={
                color={1,0,0,1}
            }
        }
    },
    {
        name="quad",
        uuid=9,
        parent=0,
        components={
            Renderer=
            {
                material="./Assets/materials/pbr",
                mesh="./Assets/meshs/Cube"
            },
            Transform={
                position={-2,0,0},
                rotation={0,0,0,0},
                scale={1,1,1},
            }
        }
    },
}
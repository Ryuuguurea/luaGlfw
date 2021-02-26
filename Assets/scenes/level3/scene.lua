return{
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

            },
            TextRenderer={
                text="This is a Sample",
                x=25,
                y=25,
                color={0.5,0.8,0.2,1}
            }
        }
    }
}
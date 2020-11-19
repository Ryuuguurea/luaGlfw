return{
    Vert="\
        #version 330 core\
        layout (location=0) in vec3 position;\
        layout (location=1) in vec3 normal;\
        layout (location=2) in vec3 tangent;\
        layout (location=3) in vec2 texcoord;\
        out vec2 aTexcoord;\
        uniform mat4 modelView;\
        uniform mat4 projection;\
        uniform vec3 color;\
        void main()\
        {\
            aTexcoord=texcoord;\
            gl_Position= projection * modelView * vec4(position,1.0f);\
        }\
    ",
    Frag="\
        #version 330 core\
        out vec4 FragColor;\
        in vec3 aColor;\
        in vec2 aTexcoord;\
        uniform sampler2D mainTex;\
        uniform vec3 color;\
        void main()\
        {\
            FragColor=vec4(aTexcoord.x,aTexcoord.y,1,1.0f);\
        }\
    ",
    mode=nil,
    cull=nil,
    blend=nil,
    properties={
        mainTex="./Assets/textures/default.png",
        color={1,1,1,1}
    },
    pass="geometry"
}
return{
    Vert="\
        #version 330 core\
        layout (location=0) in vec3 position;\
        layout (location=1) in vec3 normal;\
        layout (location=2) in vec2 texcoord;\
        out vec2 aTexcoord;\
        uniform mat4 model;\
        uniform mat4 view;\
        uniform mat4 projection;\
        uniform vec4 color;\
        void main()\
        {\
            aTexcoord=texcoord;\
            gl_Position= projection * view * model * vec4(position,1.0f);\
        }\
    ",
    Frag="\
        #version 330 core\
        out vec4 FragColor;\
        in vec2 aTexcoord;\
        uniform sampler2D mainTex;\
        uniform vec4 color;\
        void main()\
        {\
            FragColor=texture(mainTex,aTexcoord)*color;\
        }\
    ",
    cull=nil,
    blend={
        sfactor="SRC_ALPHA",
        dfactor="ONE_MINUS_SRC_ALPHA"
    },
    properties={
        mainTex="./Assets/textures/default.png",
        color={1,1,1,1}
    },
    pass="geometry"
}
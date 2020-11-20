return{
    Vert="\
        #version 330 core\
        layout (location=0) in vec3 position;\
        uniform mat4 modelView;\
        uniform mat4 projection;\
        uniform vec4 color;\
        void main()\
        {\
            gl_Position= projection * modelView * vec4(position,1.0f);\
        }\
    ",
    Frag="\
        #version 330 core\
        out vec4 FragColor;\
        uniform vec4 color;\
        void main()\
        {\
            FragColor=color;\
        }\
    ",
    properties={
        color={1,1,1,1}
    },
    cull=nil,
    pass="debug"
}
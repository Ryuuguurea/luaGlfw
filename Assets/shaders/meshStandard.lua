return{
    ["Vert"]="\
    #version 330 core\
    layout (location=0) in vec3 position;\
    uniform mat4 modelView;\
    uniform mat4 projection;\
    void main()\
    {\
        gl_Position= projection * modelView * vec4(position,1.0f);\
    }\
",
["Frag"]="\
    #version 330 core\
    out vec4 FragColor;\
    void main()\
    {\
        FragColor=vec4(0.5,0.2,0.7,1.0f);\
    }\
"
}
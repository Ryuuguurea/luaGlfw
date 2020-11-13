return 
{
    ["Blend"]="BlendOneOne",
    ["RendQueue"]=3000,
    ["Vert"]="\
        #version 330 core\
        layout (location=0) in vec3 position;\
        uniform mat4 modelView;\
        uniform mat4 projection;\
        uniform float time;\
        out vec3 vPosition;\
        void main()\
        {\
            vPosition = position;\
            vPosition.x += sin( time + vPosition.z * 4.0 ) / 4.0;\
            vPosition.y += cos( time + vPosition.z * 4.0 ) / 4.0;\
            gl_Position= projection * modelView * vec4(vPosition,1.0f);\
        }\
    ",
    ["Frag"]="\
        #version 330 core\
        out vec4 FragColor;\
        in vec3 vPosition;\
        void main()\
        {\
            FragColor=vec4( vPosition * 2.0,1.0f);\
        }\
    ",["wireframe"]=true
}
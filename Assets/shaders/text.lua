return{
    Vert="#version 330 core\
    layout (location = 0) in vec4 vertex;\
    out vec2 TexCoords;\
    uniform mat4 projection;\
    void main()\
    {\
        gl_Position = projection * vec4(vertex.xy, 0.0, 1.0);\
        TexCoords = vertex.zw;\
    }",
    Frag="#version 330 core\
    in vec2 TexCoords;\
    out vec4 FragColor;\
    uniform sampler2D text;\
    uniform vec4 color;\
    void main()\
    {\
        vec4 sampled = vec4(1.0, 1.0, 1.0, texture(text, TexCoords).r);\
        FragColor = color*sampled;\
    }",
    properties={
        color={1,1,1,1}
    }
}
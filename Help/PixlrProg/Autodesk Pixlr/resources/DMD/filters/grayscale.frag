#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif
uniform sampler2D image; 
uniform vec3 direction;// = vec3(54.0f, 182.0f, 18.0f); 

varying vec4 v_texCoord; 

void main()
{
    PRECISION vec3 dir = direction/(direction.x + direction.y + direction.z); 

    vec3 c = texture2D(image, v_texCoord.xy).xyz; 
    PRECISION float lum = dot(c, dir); 

    gl_FragColor = vec4(vec3(lum), 1.0); 
}

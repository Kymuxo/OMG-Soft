#ifdef GL_ES
#define PRECISION mediump
precision mediump float;
#else
#define PRECISION
#endif

uniform sampler2D image; 
uniform float a; 
uniform float b; 
uniform float scale; 
varying vec4 v_texCoord; 

void main()
{ 
  vec3 c = texture2D(image, v_texCoord.xy).xyz; 
  c.yz = vec2(a, b) + (c.yz - vec2(0.5))/scale; 
  gl_FragColor = vec4(c, 1.0); 
}

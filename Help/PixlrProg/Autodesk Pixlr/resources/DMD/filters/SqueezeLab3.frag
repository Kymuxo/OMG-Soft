#ifdef GL_ES
#define PRECISION mediump
precision mediump float;
#else
#define PRECISION mediump
#endif

uniform sampler2D image;
uniform float a; 
uniform float b; 
varying vec4 v_texCoord;

void main()
{
  vec4 c = texture2D(image, v_texCoord.xy); 
  c.y = a; 
  c.z = b; 
  gl_FragColor = c; 
}

#ifdef GL_ES
#define PRECISION mediump
precision mediump float;
#else
#define PRECISION
#endif

uniform PRECISION sampler2D image;
uniform vec2 u_texsize; 
uniform float top; 
uniform float bottom; 
varying vec4 v_texCoord;

void main() {
  vec4 c = texture2D(image, v_texCoord.xy); 
  c.x = bottom + (top - bottom)*c.x; 
  gl_FragColor = c; 
} 

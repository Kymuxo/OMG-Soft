#ifdef GL_ES
precision mediump float; 
#endif
uniform sampler2D image; 
uniform float sinsin; 
uniform float sincos; 
uniform float coscos; 
varying vec4 v_texCoord;

void main() 
{ 
  vec4 c = texture2D(image, v_texCoord.xy); 
  vec4 oc = c; 
  oc.y = 0.5 + (c.y - 0.5)*coscos + (c.z - 0.5)*sincos; 
  oc.z = 0.5 + (c.y - 0.5)*sincos + (c.z - 0.5)*sinsin; 
  gl_FragColor = oc; 
}

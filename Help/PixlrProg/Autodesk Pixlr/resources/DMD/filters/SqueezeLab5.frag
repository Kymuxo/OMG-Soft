#ifdef GL_ES
precision mediump float; 
#endif
uniform sampler2D image; 
uniform vec2 u_texsize; 
uniform float threshold; 
uniform float gamma_top; 
uniform float gamma_bottom; 
varying vec4 v_texCoord; 

void main() {
  vec3 c = texture2D(image, v_texCoord.xy).xyz; 
  float t = threshold; 
  c.x = (c.x < t) ? t * pow(c.x/t, gamma_bottom) : t + (1.0 - t)*pow((c.x - t)/(1.0 - t), gamma_top); 
  gl_FragColor = vec4(c, 1.0); 
}

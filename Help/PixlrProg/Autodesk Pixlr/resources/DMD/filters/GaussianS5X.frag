#ifdef GL_ES
precision highp float;
#endif
uniform sampler2D image;

uniform float w2; 
uniform float w1; 
uniform float norm; 

varying vec2 v_texcoord_m2; 
varying vec2 v_texcoord_m1; 
varying vec2 v_texcoord;   
varying vec2 v_texcoord_p1; 
varying vec2 v_texcoord_p2; 

void main()
{
  vec2 sum = vec2(0.0, 0.0); 
  sum += texture2D(image, v_texcoord).ra; 
  sum += w1*(texture2D(image, v_texcoord_m1).ra + texture2D(image, v_texcoord_p1).ra); 
  sum += w2*(texture2D(image, v_texcoord_m2).ra + texture2D(image, v_texcoord_p2).ra); 
  sum /= norm; 
  gl_FragColor = vec4(sum.x, sum.x, sum.x, sum.y); 

}

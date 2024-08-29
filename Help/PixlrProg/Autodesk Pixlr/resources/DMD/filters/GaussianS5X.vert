#ifdef GL_ES
precision mediump float;
#endif
attribute vec4 a_position;
attribute vec4 a_texcoord;

uniform vec2 Global_tileSize; 
uniform vec2 dir; 

varying vec2 v_texcoord_m2; 
varying vec2 v_texcoord_m1; 
varying vec2 v_texcoord;   
varying vec2 v_texcoord_p1; 
varying vec2 v_texcoord_p2; 

void main()
{
  gl_Position = a_position;
  v_texcoord = a_texcoord.xy;
  
  vec2 s = Global_tileSize*dir;//u_pass*d; //(0 == u_pass) ? vec2(d.x, 0.0) : vec2(0.0, d.y); 
  
  vec2 o2 = 2.0*s; 
  vec2 o1 = 1.0*s; 
  
  v_texcoord_m2 = v_texcoord - o2; 
  v_texcoord_m1 = v_texcoord - o1; 
  
  v_texcoord_p2 = v_texcoord + o2; 
  v_texcoord_p1 = v_texcoord + o1; 

}

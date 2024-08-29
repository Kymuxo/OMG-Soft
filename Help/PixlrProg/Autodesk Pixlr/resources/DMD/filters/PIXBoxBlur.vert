#ifdef GL_ES
precision highp float;
#define HIGHP highp
#else
#define HIGHP
#endif
attribute vec4 a_position;
attribute vec4 a_texcoord;

uniform HIGHP vec2 Global_tileSize; 
uniform int pass;
uniform float spread;

varying vec2 v_texcoord_m3; 
varying vec2 v_texcoord_m2; 
varying vec2 v_texcoord_m1; 
varying vec2 v_texcoord;    
varying vec2 v_texcoord_p1; 
varying vec2 v_texcoord_p2; 
varying vec2 v_texcoord_p3; 

void main()
{
  gl_Position = a_position;
  v_texcoord = a_texcoord.xy;

  vec2 d = Global_tileSize; 
  vec2 s = (0 == pass) ? vec2(d.x, 0.0) : vec2(0.0, d.y);

  v_texcoord_m3 = v_texcoord - ((spread * 5.0) + 0.5) * s;
  v_texcoord_m2 = v_texcoord - ((spread * 3.0) + 0.5) * s;
  v_texcoord_m1 = v_texcoord - ((spread * 1.0) + 0.5) * s;

  v_texcoord_p1 = v_texcoord + ((spread * 1.0) + 0.5) * s;
  v_texcoord_p2 = v_texcoord + ((spread * 3.0) + 0.5) * s;
  v_texcoord_p3 = v_texcoord + ((spread * 5.0) + 0.5) * s;
}

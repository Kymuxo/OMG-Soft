#ifdef GL_ES
precision highp float;
#define HIGHP highp
#else
#define HIGHP
#endif

attribute vec4 a_position;
attribute vec4 a_texcoord;

uniform HIGHP float o1; 
uniform HIGHP float o2; 
uniform HIGHP float o3; 
uniform vec2  dir; 
uniform vec2 Global_tileSize;

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

  HIGHP vec2 s = dir*Global_tileSize;

  v_texcoord_m3 = v_texcoord - o3*s; 
  v_texcoord_m2 = v_texcoord - o2*s; 
  v_texcoord_m1 = v_texcoord - o1*s; 

  v_texcoord_p1 = v_texcoord + o1*s; 
  v_texcoord_p2 = v_texcoord + o2*s; 
  v_texcoord_p3 = v_texcoord + o3*s; 

}

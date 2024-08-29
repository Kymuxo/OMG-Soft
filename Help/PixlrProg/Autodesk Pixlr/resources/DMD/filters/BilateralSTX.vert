#ifdef GL_ES
precision highp float;   
precision mediump int;  
#define HIGHP highp
#define MEDIUMP mediump
#else
#define HIGHP
#define MEDIUMP
#endif

attribute vec4 a_position; 
attribute vec4 a_texcoord; 

uniform int pass; 
uniform HIGHP vec2 texsize; 
uniform vec2 spread; 
uniform vec4 Global_tileRegion;
uniform vec2 Global_tileSize;

varying HIGHP vec2 v_texcoord_m3; 
varying HIGHP vec2 v_texcoord_m2; 
varying HIGHP vec2 v_texcoord_m1; 
varying HIGHP vec2 v_texcoord;    
varying HIGHP vec2 v_texcoord_p1; 
varying HIGHP vec2 v_texcoord_p2; 
varying HIGHP vec2 v_texcoord_p3; 

void main()
{
  gl_Position = a_position;
  v_texcoord = a_texcoord.xy;

  //HIGHP vec2 d = (1.0)); 
  HIGHP vec2 s = spread*Global_tileSize; //(0 == pass) ? vec2(d.x, 0.0) : vec2(0.0, d.y); 

  v_texcoord_m3 = v_texcoord - 3.0 * s; 
  v_texcoord_m2 = v_texcoord - 2.0 * s; 
  v_texcoord_m1 = v_texcoord - 1.0 * s; 

  v_texcoord_p3 = v_texcoord + 3.0 * s; 
  v_texcoord_p2 = v_texcoord + 2.0 * s; 
  v_texcoord_p1 = v_texcoord + 1.0 * s; 

}

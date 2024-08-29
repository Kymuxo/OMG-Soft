#ifdef GL_ES
precision highp float;   
precision mediump int;  
#define HIGHP highp
#define MEDIUMP mediump
#else
#define HIGHP
#define MEDIUMP
#endif
 
uniform MEDIUMP sampler2D image;
uniform float threshold; 

varying HIGHP vec2 v_texcoord_m3; 
varying HIGHP vec2 v_texcoord_m2; 
varying HIGHP vec2 v_texcoord_m1; 
varying HIGHP vec2 v_texcoord;    
varying HIGHP vec2 v_texcoord_p1; 
varying HIGHP vec2 v_texcoord_p2; 
varying HIGHP vec2 v_texcoord_p3; 

void main()
{ 
  vec2 threshold = vec2(threshold); 
  vec4 c = texture2D(image, v_texcoord); 
  float sum = c.x; 
  vec2 denom = vec2(0.5); 

  float cn, cp, cpc, cnc; 
  float dn, dp, wn, wp; 
  vec2 d, w; 

  cn = texture2D(image, v_texcoord_p1).x; 
  cp = texture2D(image, v_texcoord_m1).x; 
  cpc = cp - c.x; 
  cnc = cn - c.x; 
  d = vec2(cnc*cnc, cpc*cpc); 
  w = threshold - min(threshold,d); 
  w /= threshold; 
  denom += w; 
  sum += w.x * cn + w.y * cp; 

  cn = texture2D(image, v_texcoord_p2).x; 
  cp = texture2D(image, v_texcoord_m2).x; 
  cpc = cp - c.x; 
  cnc = cn - c.x; 
  d = vec2(cnc*cnc, cpc*cpc); 
  w = threshold - min(threshold,d); 
  w /= threshold; 
  denom += w; 
  sum += w.x * cn + w.y * cp; 

  cn = texture2D(image, v_texcoord_p3).x; 
  cp = texture2D(image, v_texcoord_m3).x; 
  cpc = cp - c.x; 
  cnc = cn - c.x; 
  d = vec2(cnc*cnc, cpc*cpc); 
  w = threshold - min(threshold,d); 
  w /= threshold; 
  denom += w; 
  sum += w.x * cn + w.y * cp; 

  gl_FragColor = vec4(sum/(denom.x+denom.y), c.y, c.z, c.w); 
}

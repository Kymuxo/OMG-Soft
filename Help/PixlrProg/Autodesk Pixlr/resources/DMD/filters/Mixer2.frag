#ifdef GL_ES
precision highp float;
#define HIGHP highp
#else
#define HIGHP
#endif

uniform sampler2D image0;
uniform sampler2D image1;
uniform float scale_width; 
uniform float scale_height; 
uniform float intensity; 
uniform vec3 color; 
uniform vec4 Global_tileRegion; 

varying HIGHP vec2 v_texcoord;

const HIGHP vec3 w = vec3(0.299, 0.587, 0.114); 

vec2 tile2World(vec2 tpos)
{
  vec2 pos = Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw;
  
  return pos;
}

vec2 world2Tile(vec2 wpos)
{
  vec2 pos = (wpos - Global_tileRegion.xy)/(Global_tileRegion.zw);

  return pos;
}

void main()
{
  vec4 ic = texture2D(image0, v_texcoord); 
  if(ic.a != 0.0)
  {
	ic.rgb /= ic.a;
  }
  HIGHP vec2 tc = tile2World(v_texcoord) * vec2(scale_width, scale_height); 
  float tone = texture2D(image1, tc).x; 
  float lum = dot(ic.rgb,w); 
  tone *= intensity; 
  vec3 oc = vec3(1.0); 
  if(lum < tone ) 
    { 
      oc = color; 
    } 
	oc.rgb *= ic.a;
  gl_FragColor = vec4(oc, ic.a); 
}

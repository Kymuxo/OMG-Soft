#ifdef GL_ES
precision highp float;
#define HIGHP highp
#else
#define HIGHP
#endif
uniform vec2 texsize; 
uniform sampler2D image0;
uniform sampler2D image1;
uniform float scale_width; 
uniform float scale_height; 
uniform float pattern_brightness; 
uniform float pattern_rotation; 
uniform float image_brightness;
uniform vec4 Global_tileRegion; 
uniform float aspectRatio[2];
varying HIGHP vec2 v_texcoord;

const HIGHP vec3 w = vec3(0.299, 0.587, 0.114); 
const float eps = 0.0000001; 
const float d = 0.01; 
const vec2 center = vec2(0.5); 

vec2 tile2World(int img, vec2 tpos)
{
  vec2 pos = (Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw)*vec2(1.0,1.0/aspectRatio[img]);
  
  return pos;
}

vec2 world2Tile(int img, vec2 wpos)
{
  vec2 pos = (vec2(1.0,aspectRatio[img])*wpos - Global_tileRegion.xy)/(Global_tileRegion.zw);

  return pos;
}

mat2 rotation = mat2(cos(pattern_rotation), sin(pattern_rotation), 
		     -sin(pattern_rotation), cos(pattern_rotation)); 

/* mat2 rotation = mat2(cos(0.0), sin(1.57),  */
/* 		     -sin(0.0), cos(1.57));  */

void main()
{
  vec4 c = texture2D(image0, v_texcoord); 

  HIGHP vec2 pcoord = center + rotation * (tile2World(1, v_texcoord) - center); 
  pcoord *= vec2(scale_width, scale_height); 
  float p = pattern_brightness * texture2D(image1, pcoord).x; 
  float cb = image_brightness * dot(c.rgb, w); 

  float ob = pow(p, (1.0 + eps - cb)/(cb + eps)); 

  gl_FragColor = vec4(vec3(ob)*c.a, c.a); 
}

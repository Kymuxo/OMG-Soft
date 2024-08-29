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
uniform float threshold; 
uniform float intensity; 
uniform vec3 color; 
uniform vec4 Global_tileRegion; 

uniform vec2 texsize; 
varying HIGHP vec2 v_texcoord;

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

void main() {
  vec4 inColor = texture2D(image0, v_texcoord);
  if(inColor.a != 0.0)
  { 
	inColor.rgb /= inColor.a;
  }
  HIGHP vec2 hc = tile2World(v_texcoord) * vec2(scale_width, scale_height); 
  vec3 tone = texture2D(image1, hc).xxx; 
  float val = length(inColor.rgb); 
  vec3 outCol = vec3(1.0);   
  if(intensity * tone.x + val < threshold)
    { 
      outCol = color; 
    } 
	
	outCol.rgb *= inColor.a;
	 
  gl_FragColor = vec4(outCol, inColor.a); 
}

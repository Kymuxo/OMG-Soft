#ifdef GL_ES
precision highp float;
#endif
uniform sampler2D image0;
uniform sampler2D image1;
uniform float scale_width; 
uniform float scale_height; 
uniform float threshold; 
uniform float strength; 
uniform float swirl;
uniform vec4 Global_tileRegion; 

varying vec2 v_texcoord;

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
  vec4 c = texture2D(image0, v_texcoord); 
  if(c.a != 0.0)
  {
	c.rgb /= c.a;
  }
  vec2 coord = tile2World(v_texcoord);
  vec2 tcoord = coord * vec2(scale_width, scale_height); 
  tcoord += swirl * c.xy; 
  vec3 t = texture2D(image1, tcoord).xxx; 
  t = strength*(vec3(threshold) - t); 
  vec3 oc = clamp(c.rgb + t, vec3(0.0), vec3(1.0));  
  oc.rgb *= c.a;
  gl_FragColor = vec4(oc, c.a); 
}

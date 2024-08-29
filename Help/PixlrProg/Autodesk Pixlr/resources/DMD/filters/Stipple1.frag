#ifdef GL_ES
precision highp float;
#define HIGHP highp
#else
#define HIGHP
#endif
uniform sampler2D image;
uniform HIGHP vec2 texsize; 
uniform float extent; 
uniform float tile;
uniform float delta; 
uniform float light; 
uniform vec4 Global_tileRegion;
uniform vec2 Global_tileSize;
uniform float aspectRatio;

varying HIGHP vec2 v_texcoord;   

vec2 tile2World(vec2 tpos)
{
  vec2 pos = (Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw)*vec2(1.0,1.0/aspectRatio);
  
  return pos;
}

vec2 world2Tile(vec2 wpos)
{
  vec2 pos = (vec2(1.0,aspectRatio)*wpos - Global_tileRegion.xy)/(Global_tileRegion.zw);

  return pos;
}

const HIGHP vec3 w = vec3(0.2125, 0.7154, 0.0721); 
const vec3 back = vec3(1.0); 
const vec3 front = vec3(0.0); 

void main()
{
  // HIGHP vec2 coord = gl_FragCoord.xy; 
  HIGHP vec2 coord = tile2World(v_texcoord); //* texsize; 
  HIGHP vec2 center = tile*(floor(coord/tile) + 0.5); 
  vec4 c1 = texture2D(image, v_texcoord);
  vec4 c2 = texture2D(image, world2Tile(center));

  vec2 steps = Global_tileSize;
  float n = 0.0;
  vec4 col = vec4(0.0,0.0,0.0,0.0);
  for(int j = -4;j <= 4;j++)
    {
      for(int i = -4;i <= 4;i++)
  	{
  	  col += texture2D(image, world2Tile(center + 0.5*tile*vec2(i,j)/9.0));
  	  n++;
  	}
    }
  col = col/n;
  float lum = light*0.5*dot(col.rgb/col.a,w);

  float s = 0.0;
  float a = 0.0;
  float radius = clamp(1.0 - lum, 0.0, 1.0)*0.5*tile;
  n = 0.0;
  for(int j = -5;j <= 5;j++)
    {
      for(int i = -5;i <= 5;i++)
	{
	  //float lum = light * 0.5 * dot(c2.rgb,w); //dot((c1 + c2), w); 
	  //vec3 c = back; 
	  float dist = length(coord + delta*(vec2(i,j)*(0.5/5.0)) - center); 	   
	  s += step(radius, dist);//smoothstep(dist - extent, dist + extent, radius);
	  n++;
	}
    }
  s = s/n;
  //float dist = length(coord - center); 	   
  //float v = step(radius, dist);
  //a = (col.a > 0.0) ? max((1.0 - s), c1.a) : 0.0;
  gl_FragColor = /*vec4(vec3(lum),c1.a);*/vec4(vec3(s*c1.a), c1.a);
}

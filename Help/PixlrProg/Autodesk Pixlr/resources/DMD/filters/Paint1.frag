#ifdef GL_ES
precision highp float; 
#define HIGHP highp
#else
#define HIGHP
#endif
uniform sampler2D image0; 
uniform sampler2D image1; 
//uniform HIGHP vec2 texsize; 
uniform float tile_size; 
uniform float threshold; 
uniform vec4 Global_tileRegion;

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

float rand(in vec2 n)
{ 
  // return sin(100.0*(n.x + n.y)); 
  return fract((n.x * n.y)/13.0); 
} 

void main()
{ 
  // HIGHP vec2 coord = gl_FragCoord.xy; 
  HIGHP vec2 coord = tile2World(v_texcoord);//*Global_tileRegion.zw; 
  HIGHP vec2 t1 = tile_size*floor(coord/tile_size); 
  HIGHP vec2 t2 = t1 + vec2(0.0, tile_size); 
  HIGHP vec2 t3 = t1 + vec2(tile_size, tile_size); 
  HIGHP vec2 t4 = t1 + vec2(tile_size, 0.0); 

  HIGHP vec2 d = coord - t1; 

  vec4 c = texture2D(image0, v_texcoord); 
  vec4 i = texture2D(image1, v_texcoord); 

  float R = 0.707106*tile_size; 

  bool h1 = d.x < d.y; 
  bool h2 = d.y < (tile_size - d.x); 

  HIGHP vec2 T1 = h1 ? t2 : t4; 
  HIGHP vec2 T2 = h2 ? t1 : t3; 

  vec4 oc = c; 

  if(distance(c.rgb,i.rgb) > threshold)
    { 
      bool n1 = length(T1 - coord) < R; 
      bool n2 = length(T2 - coord) < R; 
      HIGHP vec2 t = coord; 
      t = n1 && !n2 ? T1 : t; 
      t = n2 && !n1 ? T2 : t; 
      t = n1 && n2  ? (rand(T1) < rand(T2) ? T2 : T1) : t; 
      t = world2Tile(t);
      oc = texture2D(image1, t); 
    } 

  gl_FragColor = oc; 
}

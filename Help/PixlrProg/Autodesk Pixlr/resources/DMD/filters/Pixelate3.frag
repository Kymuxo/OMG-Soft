#ifdef GL_ES
precision mediump float;
#define HIGHP highp
#else
#define HIGHP
#endif
uniform sampler2D image;
uniform HIGHP vec2 texsize; 
uniform float tile_size; 
uniform float default_width; 
uniform vec4 Global_tileRegion;
uniform vec2 Global_tileSize;
uniform float aspectRatio;

varying HIGHP vec2 v_texcoord;   

vec2 tile2World(vec2 tpos)
{
  vec2 pos = vec2(1.0, 1.0/aspectRatio)*(Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw);
  
  return pos;
}

vec2 world2Tile(vec2 wpos)
{
  vec2 pos = (vec2(1.0, aspectRatio)*wpos - Global_tileRegion.xy)/(Global_tileRegion.zw);

  return pos;
}

void main() 
{
  HIGHP vec2 cell = vec2(tile_size); 

  vec4 col = vec4( 0.0, 0.0, 0.0, 0.0 );
  vec2 s = Global_tileSize/9.0;
  float n = 0.0;

  for(int j = -4;j <= 4;j++)
    {
      for(int i = -4;i <= 4;i++)
	{
	  vec2 coord = tile2World(v_texcoord + s*vec2(i,j))/cell;
	  HIGHP vec2 c = floor(coord); 
	  HIGHP vec2 d = fract(coord);
	  
	  bool u1 = (d.x <= d.y); 
	  bool u2 = ((1.0 - d.x) <= d.y); 
	  
	  d = (u1 && !u2) ? vec2(0.25, 0.5) : d; 
	  d = (u1 && u2) ? vec2(0.5, 0.75) : d; 
	  d = (!u1 && u2) ? vec2(0.75, 0.5) : d; 
	  d = (!u1 && !u2) ? vec2(0.5, 0.25) : d; 
	  
	  HIGHP vec2 pos = world2Tile((c + d)*cell);

	  col += texture2D(image, pos).rgba; 
	  n++;
	}
    }
  col = col/n;
  //col.a = (col.a > 0.0) ? 1.0 : 0.0;
 
  gl_FragColor = col;
}

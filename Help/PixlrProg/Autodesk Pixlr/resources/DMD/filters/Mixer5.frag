#ifdef GL_ES
precision mediump float;
#define HIGHP highp
#else
#define HIGHP
#endif

uniform sampler2D image0;
uniform sampler2D image1;
uniform vec4 Global_tileRegion;

varying HIGHP vec2 v_texcoord;

vec2 tile2World(vec2 tpos)
{
  vec2 pos = Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw;
  
  return pos;
}

void main() 
{
  vec4 c = texture2D(image0, v_texcoord); 
  vec4 e = texture2D(image1, v_texcoord);
  vec4 r = 0.5*(e + c);
  r = vec4(r.rgb*r.a,r.a);
  gl_FragColor = r; 
}

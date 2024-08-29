#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D image;
uniform vec2 u_texsize;
uniform vec2 center;
uniform vec4 Global_tileRegion;
varying vec4 v_texCoord;

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
  // Map tile coords to world coordinates
  
  vec2 pos = tile2World(v_texCoord.xy);
  vec2 normCoord = 2.0*pos.xy - 1.0;
  vec2 normCenter = 2.0*center - 1.0;

  normCoord -= normCenter;
  vec2 s = sign(normCoord);
  normCoord = abs(normCoord);
  normCoord = 0.5*normCoord + 0.5*smoothstep(0.25, 0.5, normCoord)*normCoord;
  normCoord = s*normCoord;

  normCoord += normCenter;

  vec2 textureCoordinateToUse = normCoord/2.0 + 0.5;

  vec2 tpos = world2Tile(textureCoordinateToUse);

  gl_FragColor = texture2D(image,tpos);
}

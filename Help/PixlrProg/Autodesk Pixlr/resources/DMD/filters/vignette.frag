uniform sampler2D image;
uniform vec2 u_n;
uniform vec2 u_ab;
uniform vec4 u_tcolor;
uniform vec4 Global_tileRegion;
varying vec4 v_texCoord;

const vec3 lumCoeff = vec3(0.2125,0.7154,0.0721);
void main()
{
  vec4 col = texture2D(image, v_texCoord.xy);
  vec2 realTex = Global_tileRegion.xy + v_texCoord.xy*Global_tileRegion.zw;
  vec2 c = 2.0*(0.5 - realTex.xy);
  c = pow(c/u_ab,u_n);
  float blend = c.x + c.y;
  blend = max(0.0,blend - 0.5);
  float lum = dot(col.xyz,lumCoeff);
  col = mix(col,vec4(lum,lum,lum,col.a), blend);//((blend - 1.0)));
  
  gl_FragColor = col;
}

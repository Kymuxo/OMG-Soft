/*float rnd(vec2 x)
{
    int n = int(x.x * 40.0 + x.y * 6400.0);
    n = (n << 13) ^ n;
    return 1.0 - float( (n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0;
}*/

float rnd(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

uniform sampler2D image;
uniform float u_amount;
uniform vec4 Global_tileRegion;
varying vec4 v_texCoord;

void main()
{
  vec4 col = texture2D(image, v_texCoord.xy);
  vec2 realTex = Global_tileRegion.xy + v_texCoord.xy*Global_tileRegion.zw;
  float r = mod(rnd(realTex), u_amount);
  vec4 disp = vec4(r,r,r,0.0);
  
  gl_FragColor = col + disp;
}

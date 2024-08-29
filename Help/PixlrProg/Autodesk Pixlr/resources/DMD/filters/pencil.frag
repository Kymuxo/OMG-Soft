#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif

#define M_PI 3.1415926535
uniform PRECISION float halfwidth;
uniform PRECISION float pixelwidth;
uniform PRECISION vec4 col1;
varying PRECISION vec4 v_mesh;
varying PRECISION vec4 v_params;
/*varying vec4 v_color;*/
/*
float rnd(vec2 x)
{
    int n = int(x.x * 40.0 + x.y * 6400.0);
    n = (n << 13) ^ n;
    return 1.0 - float( (n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0;
}
*/

PRECISION float rnd(PRECISION vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

PRECISION float rnd2( PRECISION vec2 co)
{
  const PRECISION float f1 = 11.2;
  const PRECISION float f2 = 65.0332;
  const PRECISION float f3 = 8899.2289;
  const PRECISION float f4 = 32921.333;
  const PRECISION float f5 = 13.333;
  const PRECISION float f6 = 7.321;
  const PRECISION float f7 = 3333.773;
  const PRECISION float f8 = 3733.1125;
   
  PRECISION float u = co.x + sin( f7 ) + f5;
  PRECISION float v = co.y + sin( f8 ) + f6;
  
  PRECISION float r = 0.5*(1.0 + sin(u*( f1 + sin(v*f2)) + v*(f3 + sin(u*f4))));
  
  return r;
}

void main()
{
  //float dist = distance(vec2(0.0,0.0),gl_TexCoord[0].xy);
  PRECISION float s = halfwidth/2.0;
  PRECISION float x = abs(v_mesh.x);
  PRECISION float n = 1.0/sqrt(2.0*M_PI*pow(s,2.0))*exp(-x/(2.0*pow(s,2.0)));
    //PRECISION float f = 1.0 - (smoothstep(halfwidth - 2.0*pixelwidth,halfwidth,dist));
    //PRECISION float s = (v_texcoord.y + 1.0)/2.0;
  PRECISION vec4 col = col1; /*gl_Color;*/ /* s*gl_Color + (1.0 - s)*vec4(0.0,0.0,1.0,1.0); */
  PRECISION float r = rnd2(v_mesh.xy);//0.5; /*noise1(v_texcoord.xy*vec2(1000.0,10000.0));*/
  r = (0.5 + r*n*0.1);
  /*n = 1.0 - n;*/
  col = vec4(n,n,n,r)*col1;/*(1.0 - n));*/
  gl_FragColor = col;
}

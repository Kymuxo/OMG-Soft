#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif

uniform PRECISION float halfwidth;
uniform PRECISION float pixelwidth;
uniform PRECISION vec4 col;
varying PRECISION vec4 v_mesh;
varying PRECISION vec4 v_params;
/*varying vec4 v_color;*/

PRECISION vec4 rnd2( PRECISION vec4 cx, PRECISION vec4 cy)
{
    const PRECISION float f1 = 11.2;
    const PRECISION float f2 = 65.0332;
    const PRECISION float f3 = 8899.2289;
    const PRECISION float f4 = 32921.333;
    const PRECISION float f5 = 13.333;
    const PRECISION float f6 = 7.321;
    const PRECISION float f7 = 3333.773;
    const PRECISION float f8 = 3733.1125;
        
    PRECISION vec4 u = cx + sin( f7 ) + f5;
    PRECISION vec4 v = cy + sin( f8 ) + f6;
    
    PRECISION vec4 r = 0.5*(1.0 + sin(u*( f1 + sin(v*f2)) + v*(f3 + sin(u*f4))));
    
    return r;
}

void main()
{
  //float dist = distance(vec2(0.0,0.0),gl_TexCoord[0].xy);
  PRECISION float rad = /*halfwidth +*/  abs(v_mesh.z);
  PRECISION float dist = abs(v_mesh.x);
  PRECISION float f = 1.0 - (smoothstep(rad - 4.0*pixelwidth,rad,dist));
  //PRECISION float s = (v_mesh.y + 1.0)/2.0;
  PRECISION vec4 col = col*f + vec4(0.0,0.0,0.0,1.0)*(1.0 - f); /*gl_Color;*/ /* s*gl_Color + (1.0 - s)*vec4(0.0,0.0,1.0,1.0); */
  //col.a = 0.25;//f*col.a;
  /*col.a = col.a*(1.0/v_params.z);*/
  /*float d = dist/rad;*/
    gl_FragColor = col; //vec4(1.0,0.0,0.0,0.5); //col1; /*vec4(d,d,d,1.0);*/ /*clamp(-sign(v_mesh.x),0.0,1.0),clamp(sign(v_mesh.x),0.0,1.0),1.0);*/
}

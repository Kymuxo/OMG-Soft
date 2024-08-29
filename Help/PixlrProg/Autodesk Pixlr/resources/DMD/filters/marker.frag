#ifdef GL_ES
#define PRECISION_HIGH highp
#define PRECISION_LOW lowp
#else
#define PRECISION_HIGH
#define PRECISION_LOW
#endif

uniform PRECISION_HIGH float halfwidth;
uniform PRECISION_HIGH float pixelwidth;
uniform PRECISION_LOW vec4 col1;
varying PRECISION_HIGH vec4 v_mesh;
varying PRECISION_HIGH vec4 v_params;
varying PRECISION_HIGH vec4 v_position;
/*varying vec4 v_color;*/

/*
PRECISION float rnd(PRECISION vec2 cx, PRECISION vec2 cy)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
*/
PRECISION_HIGH vec4 rnd2( PRECISION_HIGH vec4 cx, PRECISION_HIGH vec4 cy)
{
  const PRECISION_HIGH float f1 = 11.2;
  const PRECISION_HIGH float f2 = 65.0332;
  const PRECISION_HIGH float f3 = 8899.2289;
  const PRECISION_HIGH float f4 = 32921.333;
  const PRECISION_HIGH float f5 = 13.333;
  const PRECISION_HIGH float f6 = 7.321;
  const PRECISION_HIGH float f7 = 3333.773;
  const PRECISION_HIGH float f8 = 3733.1125;
   
  PRECISION_HIGH vec4 u = cx + sin( f7 ) + f5;
  PRECISION_HIGH vec4 v = cy + sin( f8 ) + f6;
  
  PRECISION_HIGH vec4 r = 0.5*(1.0 + sin(u*( f1 + sin(v*f2)) + v*(f3 + sin(u*f4))));
  
  return r;
}

/*
PRECISION vec4 Amult = vec4(16807.0 ,48271.0 ,16807.0, 69621.0);
PRECISION vec4 Cinc  = vec4(    0.0 ,    0.0,     0.0,     0.0);
PRECISION vec4 Mmod = vec4(4294967296.0,4294967296.0,4294967296.0,4294967296.0);
PRECISION vec4 rndLCG( PRECISION vec4 seed1, PRECISION vec4 seed2)
{
    PRECISION vec4 v = mod(Amult*(seed1 + seed2) + Cinc,2147483647.0)/2147483647.0;
    
    return v;
}
*/
/*
PRECISION float snoise(PRECISION vec2 v)
{
    const PRECISION vec4 C = vec4(0.211324865405187, // (3.0-sqrt(3.0))/6.0
                        0.366025403784439, // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626, // -1.0 + 2.0 * C.x
                        0.024390243902439); // 1.0 / 41.0
    // First corner
    PRECISION vec2 i = floor(v + dot(v, C.yy) );
    PRECISION vec2 x0 = v - i + dot(i, C.xx);
    
    // Other corners
    PRECISION vec2 i1;
    //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
    //i1.y = 1.0 - i1.x;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    PRECISION vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    
    // Permutations
    i = mod289(i); // Avoid truncation effects in permutation
    PRECISION vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
                     + i.x + vec3(0.0, i1.x, 1.0 ));
    
    PRECISION vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m*m ;
    m = m*m ;
    
    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)
    
    PRECISION vec3 x = 2.0 * fract(p * C.www) - 1.0;
    PRECISION vec3 h = abs(x) - 0.5;
    PRECISION vec3 ox = floor(x + 0.5);
    PRECISION vec3 a0 = x - ox;
    
    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
    
    // Compute final noise value at P
    PRECISION vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}
*/

void main()
{
  //float dist = distance(vec2(0.0,0.0),gl_TexCoord[0].xy);
  PRECISION_HIGH float rad = /*halfwidth +*/  abs(v_mesh.z);
  PRECISION_HIGH float dist = abs(v_mesh.x);
  PRECISION_HIGH float f = 1.0 - (smoothstep(rad - 2.0*pixelwidth,rad,dist));
  PRECISION_HIGH float s = (v_mesh.y + 1.0)/2.0;
  PRECISION_LOW vec4 col = col1; /*gl_Color;*/ /* s*gl_Color + (1.0 - s)*vec4(0.0,0.0,1.0,1.0); */
  col.a = f*col.a;

  // Need 9 random numbers to jitter positions and heights with in grid
  PRECISION_HIGH vec4 height[2];
  PRECISION_HIGH vec2 P1 = v_position.xy*0.5;
  PRECISION_HIGH vec2 dC1 = fract(P1);
  PRECISION_HIGH vec2 C1 = floor(P1);
  PRECISION_HIGH vec2 P2 = v_position.xy*0.0125;//125;
  PRECISION_HIGH vec2 dC2 = fract(P2);
  PRECISION_HIGH vec2 C2 = floor(P2);

  PRECISION_HIGH vec4 C1x = C1.xxxx + vec4(0.0, 1.0, 0.0, 1.0);
  PRECISION_HIGH vec4 C1y = C1.yyyy + vec4(0.0, 0.0, 1.0, 1.0);
  PRECISION_HIGH vec4 C2x = C2.xxxx + vec4(0.0, 1.0, 0.0, 1.0);
  PRECISION_HIGH vec4 C2y = C2.yyyy + vec4(0.0, 0.0, 1.0, 1.0);

  height[0] = rnd2(C1x,C1y);
  height[1] = rnd2(C2x,C2y);

  // Paper height
  PRECISION_HIGH vec2 ha = mix(height[0].xz,height[0].yw,dC1.x);
  PRECISION_HIGH vec2 hb = mix(height[1].xz,height[1].yw,dC2.x);
  PRECISION_HIGH float h1 = mix(ha.x,ha.y,dC1.y);
  PRECISION_HIGH float h2 = mix(hb.x,hb.y,dC2.y);
  PRECISION_HIGH float h = (h1*0.75 + h2*0.25);

  /* 
  PRECISION float r1 = rnd2(v_mesh.xy*1000.0);
  float m = 1.0 - v_params.z/100.0;
  col.rgb = col.rgb + m*vec3(0.1,0.1,0.1)*( 1.0 - 2.0*r1);
  */
  // Marker is liquid which fills holes and just barely covers hills so
  PRECISION_LOW float v = (1.0 - 0.4*h);
  col.a = v*col.a;
  /*if(rad - dist < 0.01)
    {
      col.rgb = vec3(0.0,0.0,1.0);
      }*/
    gl_FragColor = col;
}

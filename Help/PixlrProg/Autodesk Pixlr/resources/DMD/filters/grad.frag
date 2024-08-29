#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif

uniform PRECISION float halfwidth;
uniform PRECISION float pixelwidth;
uniform PRECISION vec4 col1;
varying PRECISION vec4 v_mesh;
varying PRECISION vec4 v_params;

void main()
{
  PRECISION float rad = halfwidth*abs(v_params.z);
  PRECISION float f = pow((1.0 + v_mesh.x/rad)/2.0,3.0);
  PRECISION float e = 1.0 - smoothstep(rad - 0.5*pixelwidth,rad,v_mesh.x);
  PRECISION vec4 col = col1;
  col.a = col.a*f*e;
  gl_FragColor = col;
}

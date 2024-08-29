#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif

uniform PRECISION vec4 col;

void main()
{
  gl_FragColor = col;
}

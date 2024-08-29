#ifdef GL_ES
#define PRECISION mediump
#else
#define PRECISION
#endif

varying PRECISION vec4 v_mesh;
uniform sampler2D image;
uniform PRECISION vec4 col;

void main()
{
  gl_FragColor = col*texture2D(image,v_mesh.xy);
}

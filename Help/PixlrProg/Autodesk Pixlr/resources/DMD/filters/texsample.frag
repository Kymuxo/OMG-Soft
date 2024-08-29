#ifdef GL_ES
#define PRECISION mediump
#define HIGH_PRECISION highp
#else
#define PRECISION
#define HIGH_PRECISION
#endif

varying PRECISION vec4 v_mesh;
uniform sampler2D image;
uniform HIGH_PRECISION float pixelWidth;
void main()
{
  HIGH_PRECISION vec4 col = texture2D(image,v_mesh.xy + vec2(0.0, 0.0));
  col += texture2D(image,v_mesh.xy + vec2(pixelWidth, 0.0) );
  col += texture2D(image,v_mesh.xy + vec2(-pixelWidth, 0.0));
  col += texture2D(image,v_mesh.xy + vec2(0.0, pixelWidth));
  col += texture2D(image,v_mesh.xy + vec2(0.0,-pixelWidth));
  gl_FragColor = col/5.0;
}

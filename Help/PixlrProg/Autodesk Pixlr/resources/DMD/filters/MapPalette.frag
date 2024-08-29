#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH 
precision highp float; 
#else 
precision mediump float; 
#endif 
#endif

uniform sampler2D image0;
uniform sampler2D image1;
varying vec2 v_texcoord;

void main()
{
  vec4 c = texture2D(image0, v_texcoord);
  vec3 p = floor(255.0 * c.rgb); 
  vec2 cr = vec2(mod(p.r, 16.0), floor(p.r/16.0))/16.0; 
  vec2 cg = vec2(mod(p.g, 16.0), floor(p.g/16.0))/16.0; 
  vec2 cb = vec2(mod(p.b, 16.0), floor(p.b/16.0))/16.0; 

  vec3 oc; 
  oc.r = texture2D(image1, cr).r;
  oc.g = texture2D(image1, cg).g;
  oc.b = texture2D(image1, cb).b;

  gl_FragColor = vec4(oc, c.a); 
}

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH 
precision highp float; 
#else 
precision mediump float; 
#endif
#define HIGHP highp
#define MEDIUMP mediump 
#else
#define HIGHP
#define MEDIUMP 
#endif

uniform sampler2D image; 
varying vec2 v_texcoord; 

const vec3 ONE = vec3(1.0); 

void main()
{ 
  vec4 c = texture2D(image, v_texcoord); 
  vec3 oc = ONE - c.rgb; 
  gl_FragColor = vec4(oc, c.a); 
}

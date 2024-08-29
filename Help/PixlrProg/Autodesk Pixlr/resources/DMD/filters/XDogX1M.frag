#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D image0;
uniform sampler2D image1;
uniform float p; 
uniform float e; 
uniform vec3 color; 

varying vec2 v_texcoord;

void main()
{
  vec2 d1 = texture2D(image0, v_texcoord).ra; 
  if(d1.y != 0.0)
  {
	 d1.x /= d1.y;
  }
  vec2 d2 = texture2D(image1, v_texcoord).ra; 
  float H = 100.0*((1.0 + p)*d1.x - p*d2.x); 
  vec3 edge = (H > e) ? vec3(1.0) : color;
  float Ha =  100.0*((1.0 + p)*d1.y - p*d2.y);
  float a = (Ha > e) ? 1.0 : 0.0;
  edge.rgb *= a;
  gl_FragColor = vec4(edge, a); 

}

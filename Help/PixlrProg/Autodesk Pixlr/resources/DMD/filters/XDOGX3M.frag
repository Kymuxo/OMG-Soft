#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image0;
uniform sampler2D image1;
uniform float p; 
uniform float e; 
uniform float phi; 

varying vec2 v_texcoord;
void main() 
{
  vec2 d1 = texture2D(image0, v_texcoord).ra; 
  if(d1.y != 0.0)
  {
	 d1.x /= d1.y;
  }
  vec2 d2 = texture2D(image1, v_texcoord).ra; 
  vec2 H = 100.0 * ((1.0 + p)* d1 - p*d2); 
  vec2 edge = smoothstep(0.0, e, phi*H); 
  vec3 color = vec3(edge.x);
  color.rgb *= edge.y;
  gl_FragColor = vec4(color, edge.y); 

}

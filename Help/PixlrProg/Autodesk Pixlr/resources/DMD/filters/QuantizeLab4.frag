#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D image0;
uniform sampler2D image1;
varying vec4 v_texCoord;
void main()
{
  vec3 c = texture2D(image0, v_texCoord.xy).xyz; 
  float L = texture2D(image1, v_texCoord.xy).x; 
  c.x = L; 
  gl_FragColor = vec4(c, 1.0); 

}

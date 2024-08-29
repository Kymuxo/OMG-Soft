#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image1;
uniform sampler2D image2;
varying vec4 v_texCoord;

void main()
{
  vec3 c = texture2D(image1, v_texCoord.xy).xyz; 
  float L = texture2D(image2, v_texCoord.xy).x; 
  c.x = L; 
  gl_FragColor = vec4(c, 1.0); 
}

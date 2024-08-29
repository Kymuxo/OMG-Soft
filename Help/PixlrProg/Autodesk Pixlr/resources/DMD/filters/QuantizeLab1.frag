#ifdef GL_ES
precision mediump float; 
#endif

uniform sampler2D image;
uniform float phi; 
uniform float bins; 
varying vec4 v_texCoord;

void main()
{
  vec3 c = texture2D(image, v_texCoord.xy).xyz; 
  float qn = floor(c.x * bins + 0.5)/bins; 
  float qs = smoothstep(-2.0, 2.0, phi * (c.x - qn)*100.0) - 0.5; 
  float qc = qn + qs/bins; 
  gl_FragColor = vec4(vec3(qc, c.yz), 1.0); 
}

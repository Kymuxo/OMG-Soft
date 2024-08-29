#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image;

uniform float phi; 
uniform float bins; 
uniform float threshold; 
uniform float flood; 
varying vec4 v_texCoord;

void main()
{
  vec3 c = texture2D(image, v_texCoord.xy).rgb; 
  float qc = c.x; 

  if(qc < threshold)
    { 
      float qn = floor(c.x * bins + 0.5)/bins; 
      float qs = smoothstep(-2.0, 2.0, phi * (c.x - qn)*100.0) - 0.5; 
      qc = qn + qs/bins; 
    }
  else 
    { 
      qc = flood; 
    } 

  gl_FragColor = vec4(vec3(qc, c.yz), 1.0); 
} 

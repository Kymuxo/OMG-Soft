#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D image;
uniform vec3 color_top; 
uniform vec3 color_bottom; 
uniform float threshold; 
varying vec4 v_texCoord;

const vec3 w = vec3(0.299, 0.587, 0.114);

void main()
{
  vec3 c = texture2D(image, v_texCoord.xy).rgb;
  float lum = dot(c, w);
  if(lum > threshold) 
    gl_FragColor=vec4(color_top, 1.0);  
  else 
    gl_FragColor = vec4(color_bottom, 1.0); 
}

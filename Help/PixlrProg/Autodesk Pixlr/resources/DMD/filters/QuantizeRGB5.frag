#ifdef GL_ES
precision mediump float; 
#endif
uniform sampler2D image; 
uniform vec3 color_top;  
uniform vec3 color_middle;  
uniform vec3 color_bottom;  
uniform float threshold_top;  
uniform float threshold_bottom;  
varying vec4 v_texCoord; 

const vec3 w = vec3(0.299, 0.587, 0.114); 
	            
void main()
{ 
  vec4 c = texture2D(image, v_texCoord.xy); 
  if(c.a != 0.0)
  {
	 c.rgb /= c.a;
  }
  float lum = dot(c.rgb, w); 
  vec3 col = vec3(0.0);  
  col += color_top * step(threshold_top, lum);  
  col += color_middle * step(lum, threshold_top) * step(threshold_bottom, lum);  
  col += color_bottom * step(lum, threshold_bottom);  

  col.rgb *= c.a;

  gl_FragColor = vec4(col, c.a);  
}

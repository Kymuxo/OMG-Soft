#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image;

uniform vec3 color_1; 
uniform vec3 color_2; 
uniform vec3 color_3; 
uniform vec3 color_4; 
uniform vec3 color_5; 

uniform float level_1; 
uniform float level_2; 
uniform float level_3; 
uniform float level_4; 

uniform vec3 direction; 

varying vec4 v_texCoord;

void main()
{
  vec3 c = texture2D(image, v_texCoord.xy).rgb;
  float lum = dot(c, direction);
  vec3 col = color_5 * step(level_4, lum); 
  col += color_4 * step(lum, level_4) * step(level_3, lum); 
  col += color_3 * step(lum, level_3) * step(level_2, lum); 
  col += color_2 * step(lum, level_2) * step(level_1, lum); 
  col += color_1 * step(lum, level_1); 

  gl_FragColor = vec4(col, 1.0); 
}


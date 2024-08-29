#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH 
precision highp float; 
#else 
precision mediump float; 
#endif // Gl_FRAGMENT_PRECISION_HIGH
#endif // GL_ES 

uniform sampler2D image;

varying vec2 v_texcoord_m3; 
varying vec2 v_texcoord_m2; 
varying vec2 v_texcoord_m1; 
varying vec2 v_texcoord;    
varying vec2 v_texcoord_p1; 
varying vec2 v_texcoord_p2; 
varying vec2 v_texcoord_p3; 

void main()
{
  vec3 sum = vec3(0.0); 
  sum += texture2D(image, v_texcoord_m3).rgb;
  sum += texture2D(image, v_texcoord_m2).rgb;
  sum += texture2D(image, v_texcoord_m1).rgb;
  sum += texture2D(image, v_texcoord_p1).rgb;
  sum += texture2D(image, v_texcoord_p2).rgb;
  sum += texture2D(image, v_texcoord_p3).rgb;
  sum *= 2.0; 
  vec4 c = texture2D(image, v_texcoord);
  sum += c.rgb; 
  sum /= 13.0; 

  gl_FragColor = vec4(sum, c.a); 
}

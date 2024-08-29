#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image;
uniform vec2 u_texsize; 
uniform float bins_r; 
uniform float bins_g; 
uniform float bins_b; 
uniform float gamma_r; 
uniform float gamma_g; 
uniform float gamma_b; 
uniform float threshold; 
uniform vec3 flood; 
varying vec4 v_texCoord;

const vec3 w = vec3(0.299, 0.587, 0.114);

void main()
{
  vec3 bins = vec3(bins_r, bins_g, bins_b); 
  vec3 gamma = vec3(gamma_r, gamma_g, gamma_b); 
  vec3 c = texture2D(image, v_texCoord.xy).rgb; 
  if(length(c) < threshold)
    { 
      //  if(dot(c,w) < threshold) { 
      c = pow(c, gamma); 
      c = floor(c * bins)/(bins-vec3(1.0)); 
      c = pow(c, vec3(1.0/gamma)); 
    }
  else 
    { 
      c = flood/255.0; 
    } 

  gl_FragColor = vec4(c, 1.0); 
}

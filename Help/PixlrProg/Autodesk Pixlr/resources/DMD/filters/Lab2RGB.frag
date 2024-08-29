#ifdef GL_ES
#define PRECISION highp
precision highp float;
#else
#define PRECISION
#endif

uniform sampler2D image; 
varying vec4 v_texCoord; 

vec3 lab2xyz( in vec3 c) { 
  float fy = (c.x + 16.0)/116.0; 
  float fx =  0.002*c.y + fy; 
  float fz = -0.005*c.z + fy; 
  vec3 v;  
  v.x = 95.0470 * ((fx > 0.206897) ? fx*fx*fx : (fx - 16.0/116.0)/7.787); 
  v.y = 100.000 * ((fy > 0.206897) ? fy*fy*fy : (fy - 16.0/116.0)/7.787); 
  v.z = 108.883 * ((fz > 0.206897) ? fz*fz*fz : (fz - 16.0/116.0)/7.787); 
  return v; 
} 

vec3 xyz2rgb(in vec3 c) { 
  vec3 v = c / 100.0 * mat3( 3.2406, -1.5372, -0.4986,  
			     -0.9689,  1.8758,  0.0415,   
			     0.0557, -0.2040,  1.0570);  
  vec3 r; 
  r.x = (v.r > 0.0031308) ? ((1.055*pow(v.r, (1.0/2.4)))-0.055) : 12.92*v.r; 
  r.y = (v.g > 0.0031308) ? ((1.055*pow(v.g, (1.0/2.4)))-0.055) : 12.92*v.g; 
  r.z = (v.b > 0.0031308) ? ((1.055*pow(v.b, (1.0/2.4)))-0.055) : 12.92*v.b; 
  return r; 
} 

vec3 Lab2RGB(in vec3 c) { 
  vec3 v; 
  v.x = 100.0 * c.x; 
  v.y = 2.0 * 127.0 * (c.y - 0.5);  
  v.z = 2.0 * 127.0 * (c.z - 0.5);  
  return xyz2rgb(lab2xyz(v));       
}  

void main() { 
  vec4 c = texture2D(image, v_texCoord.xy);  
  if(c.a != 0.0)
  {
	c.rgb /= c.a;
  }
  vec3 color = clamp(Lab2RGB(clamp(c.xyz, 0.0, 1.0)), 0.0, 1.0); 
  color.rgb *= c.a;
  gl_FragColor= vec4(color, c.a); 
}

#ifdef GL_ES
#define PRECISION highp
precision highp float;
#else
#define PRECISION
#endif

uniform sampler2D image; 
varying vec4 v_texCoord; 

vec3 rgb2xyz(in vec3 c) 
{ 
  vec3 v; 
  v.x = (c.r > 0.04045) ? pow((c.r + 0.055)/1.055, 2.4) : c.r/12.92; 
  v.y = (c.g > 0.04045) ? pow((c.g + 0.055)/1.055, 2.4) : c.g/12.92; 
  v.z = (c.b > 0.04045) ? pow((c.b + 0.055)/1.055, 2.4) : c.b/12.92; 

  return 100.0 * v * mat3(	0.4124,	0.3576, 0.1805,	 
				0.2126,	0.7152,	0.0722,	 
				0.0193, 0.1192,	0.9505); 
} 

vec3 xyz2lab(in vec3 c)
{ 	
  vec3 n = c / vec3(95.047, 100.0, 108.883); 
  vec3 v; 
  v.x = (n.x > 0.0088560) ? pow(n.x, 1.0/3.0) : (7.787 * n.x) + (16.0/116.0); 
  v.y = (n.y > 0.0088560) ? pow(n.y, 1.0/3.0) : (7.787 * n.y) + (16.0/116.0); 
  v.z = (n.z > 0.0088560) ? pow(n.z, 1.0/3.0) : (7.787 * n.z) + (16.0/116.0); 
  vec3 r; 
  r.x = 116.0 * v.y - 16.0; 
  r.y = 500.0 * (v.x - v.y); 
  r.z = 200.0 * (v.y - v.z); 
  return r; 
} 

vec3 RGB2Lab(vec3 c)
{  
  vec3 lab = xyz2lab(rgb2xyz(c)); 
  lab.x = lab.x/100.0; 
  lab.y = 0.5 + 0.5 * (lab.y/127.0); 
  lab.z = 0.5 + 0.5 * (lab.z/127.0); 
  return lab; 
} 

void main()
{ 
  vec4 color = texture2D(image, v_texCoord.xy); 
  vec3 lab = RGB2Lab(color.rgb); 
  gl_FragColor= vec4(lab, color.a); 
}

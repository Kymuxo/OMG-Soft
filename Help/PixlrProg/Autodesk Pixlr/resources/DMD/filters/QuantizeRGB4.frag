#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image;
uniform float bins_l; 
uniform float bins_u; 
uniform float bins_v; 
varying vec4 v_texCoord;

////////////////////////////////////////////
vec3 rgb2xyz(in vec3 c) {             
  vec3 v;                              
  v.x = (c.r > 0.04045) ? pow((c.r + 0.055)/1.055, 2.4) : c.r/12.92; 
  v.y = (c.g > 0.04045) ? pow((c.g + 0.055)/1.055, 2.4) : c.g/12.92; 
  v.z = (c.b > 0.04045) ? pow((c.b + 0.055)/1.055, 2.4) : c.b/12.92; 

  return 100.0 * v * mat3(	0.4124,	0.3576, 0.1805,	 
				0.2126,	0.7152,	0.0722,	 
				0.0193, 0.1192,	0.9505); 
} 

////////////////////////////////////////////
vec3 xyz2luv(in vec3 c) {  	
  float X = c.x; 
  float Y = c.y; 
  float Z = c.z; 

  float var_U = (4.0 * X)/(X + (15.0 * Y) + (3.0 * Z)); 
  float var_V = (9.0 * Y)/(X + (15.0 * Y) + (3.0 * Z)); 

  float var_Y = Y / 100.0; 
  var_Y = (var_Y > 0.008856) ? pow(var_Y, (1.0/3.0)) : (7.787 * var_Y) + (16.0 / 116.0); 

  float ref_X = 95.047; 
  float ref_Y = 100.0; 
  float ref_Z = 108.883; 

  float ref_U = (4.0 * ref_X)/(ref_X + (15.0 * ref_Y) + (3.0 * ref_Z)); 
  float ref_V = (9.0 * ref_Y)/(ref_X + (15.0 * ref_Y) + (3.0 * ref_Z)); 

  float cie_L = (116.0 * var_Y) - 16.0; 
  float cie_u = 13.0 * cie_L * (var_U - ref_U); 
  float cie_v = 13.0 * cie_L * (var_V - ref_V); 
  return vec3(cie_L, cie_u, cie_v); 
} 

////////////////////////////////////////////
vec3 luv2xyz(vec3 c) {  
  float cie_L = c.x;    
  float cie_u = c.y;    
  float cie_v = c.z;    
  float var_Y = (cie_L + 16.0)/116.0; 
  var_Y = (pow(var_Y,3.0) > 0.008856) ? pow(var_Y,3.0) : (var_Y - 16.0/116.0)/7.787; 
  float ref_X = 95.047;  
  float ref_Y = 100.0;   
  float ref_Z = 108.883; 

  float ref_U = (4.0*ref_X)/(ref_X + 15.0*ref_Y + 3.0*ref_Z); 
  float ref_V = (9.0*ref_Y)/(ref_X + 15.0*ref_Y + 3.0*ref_Z); 
  float var_U = cie_u/(13.0*cie_L) + ref_U; 
  float var_V = cie_v/(13.0*cie_L) + ref_V; 

  float Y = 100.0*var_Y; 
  float X = -(9.0 * Y * var_U)/((var_U - 4.0)*var_V - var_U * var_V); 
  float Z = (9.0 * Y - (15.0 * var_V * Y) - (var_V * X))/(3.0 * var_V); 
  return vec3(X,Y,Z); 
} 

/////////////////////////////////////////
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


////////////////////////////////////////////
vec3 RGB2Luv(vec3 c) {  
  vec3 luv = xyz2luv(rgb2xyz(c));    
  luv.x = luv.x/100.0;               
  luv.y = 0.5 + 0.5 * (luv.y/100.0); 
  luv.z = 0.5 + 0.5 * (luv.z/100.0); 
  return luv; 
} 

////////////////////////////////////////////
vec3 Luv2RGB(vec3 c) {  
  vec3 luv = c; 
  luv.x = 100.0 * c.x; 
  luv.y = 200.0*(c.y - 0.5); 
  luv.z = 200.0*(c.z - 0.5); 

  vec3 rgb = xyz2rgb(luv2xyz(luv));    
  return rgb; 
} 

void main() {
  vec3 bins = vec3(bins_l, bins_u, bins_v); 
  vec3 rgb = texture2D(image, v_texCoord.xy).rgb; 
  vec3 luv = RGB2Luv(rgb); 
  luv = floor(luv*bins)/(bins - vec3(1.0)); 
  rgb = Luv2RGB(luv); 
  gl_FragColor = vec4(rgb, 1.0); 
}

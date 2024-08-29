#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH 
precision highp float; 
#else 
precision mediump float; 
#endif 
#endif

uniform sampler2D image;
uniform vec2 start_point; 
uniform vec2 end_point;  

uniform vec4 color_1; 
uniform vec4 color_2; 
uniform vec4 color_3; 
uniform vec4 color_4; 

uniform float location_1; 
uniform float location_2; 
uniform float location_3; 
uniform float location_4; 

varying vec2 v_texcoord;   

uniform vec4 Global_tileRegion;

vec2 tile2World(vec2 tpos)
{
  vec2 pos = (Global_tileRegion.xy + tpos.xy*Global_tileRegion.zw);
  
  return pos;
}

vec2 world2Tile(vec2 wpos)
{
  vec2 pos = (wpos - Global_tileRegion.xy)/(Global_tileRegion.zw);

  return pos;
}

void main() {
	vec2 world_texcoord = tile2World(v_texcoord);
	float d = distance(end_point, start_point); 
	vec2 unit = normalize(end_point - start_point); 
	float pos = dot((world_texcoord - start_point), unit)/d;

	//use the texture sampler in a useless way so that it doesn't get deleted during optimization,
	//otherwise, v_texcoord will always be zero!
	float r = texture2D(image, v_texcoord).r;
	vec4 c = color_1*step(255.0, r);
	
	float x; 
	if(pos <= location_1) {
		c = color_1;
	} 
	else if(location_1 < pos && pos <= location_2) { 
		x = (pos - location_1)/(location_2 - location_1); 
		c = (1.0 - x)*color_1 + x*color_2; 
	} 
	else if(location_2 < pos && pos <= location_3) { 
		x = (pos - location_2)/(location_3 - location_2); 
		c = (1.0 - x)*color_2 + x*color_3; 
	} 
	else if(location_3 < pos && pos <= location_4) { 
		x = (pos - location_3)/(location_4 - location_3); 
		c = (1.0 - x)*color_3 + x*color_4; 
	} 
	gl_FragColor = c; 
}
#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH 
precision highp float; 
#else 
precision mediump float; 
#endif
#define HIGHP highp
#define MEDIUMP mediump 
#else
#define HIGHP
#define MEDIUMP 
#endif

uniform sampler2D image1;
uniform sampler2D image2;
uniform float opacity; 
varying vec2 v_texcoord;

float Hue2Color(float v1, float v2, float vH) { 
	if( vH < 0.0) { vH += 1.0; } 
	if( vH > 1.0) { vH -= 1.0; } 
	if( 6.0*vH < 1.0) { return (v1 + 6.0*vH*(v2 - v1)); } 
	if( 2.0*vH < 1.0) { return v2; } 
	if( 3.0*vH < 2.0) { return (v1 + 6.0*(v2 - v1)*((2.0/3.0) - vH)); } 
	return v1; 
} 

vec3 RGB2HSL(in vec3 c) { 
	float H = 0.0; 
	float S = 0.0; 
	float L = 0.0; 
	float n = min(c.r, min(c.g, c.b)); 
	float x = max(c.r, max(c.g, c.b)); 
	float d = x - n; 
	L = 0.5*(x + n); 

	if( d == 0.0) { 
		H = 0.0; 
		S = 0.0; 
	} 
	else { 
		if( L < 0.5) { S = d/(x + n); } 
		else { S = d/(2.0 - x - n); } 

		float dr = (0.5*d + (x - c.r)/6.0)/d; 
		float dg = (0.5*d + (x - c.g)/6.0)/d; 
		float db = (0.5*d + (x - c.b)/6.0)/d; 

		if( c.r == x) { H = db - dg; } 
		else if( c.g == x) { H = (1.0/3.0) + dr - db; } 
		else if( c.b == x) { H = (2.0/3.0) + dg - dr; } 

		if( H < 0.0) { H += 1.0; } 
		if( H > 1.0) { H -= 1.0; } 
	} 
	return vec3(H, S, L); 
} 

vec3 HSL2RGB(in vec3 c) { 
	float H = c.x; 
	float S = c.y; 
	float L = c.z; 

	float R = L; 
	float G = L; 
	float B = L; 

	if( S != 0.0) { 
		float v2 = L + S - S*L; 
		if( L < 0.5) { v2 = L * (1.0 + S); } 
		float v1 = 2.0*L - v2; 
		R = Hue2Color(v1, v2, H + (1.0/3.0)); 
		G = Hue2Color(v1, v2, H); 
		B = Hue2Color(v1, v2, H - (1.0/3.0)); 
	} 
	return vec3(R, G, B); 
} 

void main() { 
	vec4 base = texture2D(image1, v_texcoord); 
	vec4 blend = texture2D(image2, v_texcoord); 

	vec3 base_hsl = RGB2HSL(base.rgb); 
	vec3 blend_hsl = RGB2HSL(blend.rgb); 
	float H = base_hsl.x; 
	float S = blend_hsl.y; 
	float L = base_hsl.z; 
	vec3 CB = HSL2RGB(vec3(H, S, L)); 

	float ab = base.a; 
	float as = blend.a * opacity; 
	float ar = ab + as - ab * as; 
	vec3 Cr = (1.0 - as/ar)*base.rgb + (as/ar)*((1.0 - ab)*blend.rgb + ab*CB); 

	gl_FragColor = vec4(Cr, ar); 
} 
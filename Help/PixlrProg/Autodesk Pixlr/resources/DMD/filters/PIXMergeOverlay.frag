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

uniform sampler2D image0;
uniform sampler2D image1; 
uniform float opacity; 
varying vec2 v_texcoord;

const vec3 lum = vec3(0.2125, 0.7154, 0.0721); 
const vec3 white = vec3(1.0); 

void main() {
	vec4 base = texture2D(image0, v_texcoord); 
	vec4 blend = texture2D(image1, v_texcoord); 

	vec3 CB = white; 
	float l = dot(base.rgb, lum); 
	vec3 r1 = 2.0 * blend.rgb * base.rgb; 
	vec3 r2 = white - 2.0 * (white - blend.rgb) * (white - base.rgb); 
	if(l < 0.45) {
		CB = r1; 
		} 
	else if (l > 0.55) { 
		CB = r2; 
		} 
	else { 
		CB = mix(r1, r2, (l - 0.45) * 10.0); 
	} 

	float ab = base.a; 
	float as = blend.a * opacity; 
	float ar = ab + as - ab * as; 
	vec3 Cr = (1.0 - as/ar)*base.rgb + (as/ar)*((1.0 - ab)*blend.rgb + ab*CB); 

	gl_FragColor = vec4(Cr, ar); 
}
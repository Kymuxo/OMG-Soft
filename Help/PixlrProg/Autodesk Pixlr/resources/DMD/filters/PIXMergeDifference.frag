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

void main() {
	vec4 base = texture2D(image0, v_texcoord); 
	vec4 blend = texture2D(image1, v_texcoord); 

	vec3 CB = abs(base.rgb - blend.rgb); 

	float ab = base.a; 
	float as = blend.a * opacity; 
	float ar = ab + as - ab * as; 
	vec3 Cr = (1.0 - as/ar)*base.rgb + (as/ar)*((1.0 - ab)*blend.rgb + ab*CB); 

	gl_FragColor = vec4(Cr, ar); 
}
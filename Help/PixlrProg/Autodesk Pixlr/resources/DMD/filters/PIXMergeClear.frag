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

void main() {
	gl_FragColor = vec4(0.0); 
}
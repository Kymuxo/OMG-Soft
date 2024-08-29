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
varying vec2 v_texcoord;

void main() {
   vec4 blend = texture2D(image1, v_texcoord); 
   gl_FragColor = blend; 
}
#ifdef GL_ES
precision mediump float; 
#endif

uniform sampler2D image;
uniform vec2 u_texsize; 
uniform float position; 
uniform float left; 
uniform float middle; 
uniform float right; 

varying vec4 v_texCoord;

void main()
{
vec3 c = texture2D(image, v_texCoord.xy).xyz; 
				     float l = left + c.x * (middle - left)/position; 
float r = c.x * (right - middle)/(1.0 - position) + (middle - right*position)/(1.0 - position); 
c.x = (c.x < position) ? l : r; 
gl_FragColor = vec4(c, 1.0); 
}

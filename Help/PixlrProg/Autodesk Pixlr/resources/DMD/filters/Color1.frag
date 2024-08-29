#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D image;
uniform vec3 color; 
varying vec2 v_texcoord;

void main()
{
  gl_FragColor = vec4(color, 1.0); 
}

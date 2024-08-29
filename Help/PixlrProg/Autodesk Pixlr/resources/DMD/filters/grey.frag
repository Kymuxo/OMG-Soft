// our texture
uniform sampler2D image;
uniform float u_sat;
uniform float u_bright;
// the texCoords passed in from the vertex shader.
varying vec4 v_texCoord;

void main()
{
  // Look up a color from the texture.
  vec3 col = u_bright*texture2D(image, v_texCoord.xy).rgb;
  vec3 c2g =  vec3(0.2989, 0.5870, 0.1140);
  float g = dot(col,c2g);
  gl_FragColor = (1.0 - u_sat)*vec4(g,g,g,1.0) + u_sat*vec4(col.r,col.g,col.b,1.0);
}

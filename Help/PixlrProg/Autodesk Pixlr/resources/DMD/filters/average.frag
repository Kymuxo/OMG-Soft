uniform sampler2D image;
uniform float u_width;
uniform vec2 u_axis;
uniform vec2 u_texSize;
uniform vec2 Global_tileSize;
uniform vec4 Global_tileRegion;
varying vec4 v_texCoord;

void main()
{
  //gl_FragColor = vec4(v_texCoord.x, v_texCoord.y,0,1);

  // Take the central sample first...
  vec2 realTex = v_texCoord.xy;
  //vec2 realTex = Global_tileRegion.xy + v_texCoord.xy*Global_tileRegion.zw;
  //vec4 col = texture2D(image, realTex);
  float count = 1.0;
  vec4 avgValue = texture2D(image, realTex);

  // Go through the remaining vertical samples (on each side of the center)
  for (float i = 1.0; i <= u_width; i++)
    { 
      avgValue += texture2D(image, realTex - i*Global_tileSize*u_axis);
      avgValue += texture2D(image, realTex + i*Global_tileSize*u_axis);
      count += 2.0;
    }

  gl_FragColor = avgValue/count;

}

uniform sampler2D image;
uniform float u_width;
uniform vec2 u_blurAxis;
uniform float u_sigma;
uniform vec2 Global_tileSize;
uniform vec4 Global_tileRegion;
//uniform vec2 Global_texCoordOffset;
const float pi = 3.14159265;

varying vec4 v_texCoord;

void main()
{
  // Incremental Gaussian Coefficent Calculation (See GPU Gems 3 pp. 877 - 889)
  vec3 incrementalGaussian;
  incrementalGaussian.x = 1.0/(sqrt(2.0*pi)*u_sigma);
  incrementalGaussian.y = exp(-0.5/(u_sigma*u_sigma));
  incrementalGaussian.z = incrementalGaussian.y * incrementalGaussian.y;

  vec4 avgValue = vec4(0.0, 0.0, 0.0, 0.0);
  float coefficientSum = 0.0;

  // Take the central sample first...
  vec2 realTex = v_texCoord.xy;
  //vec2 realTex = Global_tileRegion.xy + v_texCoord.xy*Global_tileRegion.zw;
  //vec4 col = texture2D(image, realTex);
  
  avgValue += texture2D(image, realTex) * incrementalGaussian.x;
  coefficientSum += incrementalGaussian.x;
  incrementalGaussian.xy *= incrementalGaussian.yz;

  // Go through the remaining vertical samples (on each side of the center)
  for (float i = 1.0; i <= u_width; i++)
    { 
      avgValue += texture2D(image, realTex - i*Global_tileSize*u_blurAxis)*incrementalGaussian.x;         
      avgValue += texture2D(image, realTex + i*Global_tileSize*u_blurAxis)*incrementalGaussian.x;         
      coefficientSum += 2.0*incrementalGaussian.x;
      incrementalGaussian.xy *= incrementalGaussian.yz;
    }

  gl_FragColor = avgValue/coefficientSum;
  
  //gl_FragColor = col;
}

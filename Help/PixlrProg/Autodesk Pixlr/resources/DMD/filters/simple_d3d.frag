// uniform sampler2D image; 
// uniform float amount; 
// varying vec2 v_texcoord; 
// 
// /* Contrast */
// void main() { 
// 	vec4 c = texture2D(image, v_texcoord); 
// 	vec3 oc = (1.0 + amount)*c.rgb - vec3(0.5*amount); 
// 	gl_FragColor = vec4(oc, c.a); 
// }

Texture2D Texture;
SamplerState ss;

float4 main(float4 position : SV_POSITION, float2 texcoord : TEXCOORD) : SV_TARGET
{
	float4 color = Texture.Sample(ss, texcoord);
	float grey = color.r * 0.299 + color.g * 0.587 + color.b * 0.144;
//	return float4(grey, grey, grey, 1.0);

	// Start with a simple color
	return float4(1.0, 1.0f, 1.0f, 1.0f);
}
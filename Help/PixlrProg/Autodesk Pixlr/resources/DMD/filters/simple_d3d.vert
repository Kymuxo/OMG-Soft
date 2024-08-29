// void main()
// {
//   vec4 pos = Global_Proj*a_vertex;    
//   gl_Position = pos;
//   gl_Position.z = 0.5;
//   v_mesh = a_mesh;
//   v_params = a_params;
//   gl_PointSize = 20.0;
// }

struct VOut
{
	float4 position: SV_POSITION;
	float2 texcoord : TEXCOORD;
};

VOut main( float4 pos : POSITION, float2 texcoord : TEXCOORD )
{
	VOut output;

	output.position = pos;
	output.texcoord = texcoord;

	return output;
}
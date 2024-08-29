#ifdef GL_ES
#define PRECISION highp
#else
#define PRECISION
#endif

uniform PRECISION mat4 Global_Proj;
uniform PRECISION mat4 Global_texTrans;
uniform PRECISION vec4 Scale;
attribute PRECISION vec4 a_vertex;
attribute PRECISION vec4 a_mesh;

varying PRECISION vec2 v_texcoord;

void main()
{
  vec4 pos = Global_Proj*a_vertex;    
  gl_Position = pos;
  gl_Position.z = 0.5;
  v_texcoord = a_mesh.xy;//*Scale;
  gl_PointSize = 20.0;
}

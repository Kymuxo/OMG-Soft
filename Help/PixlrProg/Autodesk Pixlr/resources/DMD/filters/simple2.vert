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

varying PRECISION vec4 v_texCoord;

void main()
{
  vec4 pos = Global_Proj*a_vertex;    
  gl_Position = pos;
  gl_Position.z = 0.5;
  v_texCoord = a_mesh;//*Scale;
  gl_PointSize = 20.0;
}

#ifdef GL_ES
#define PRECISION highp
#else
#define PRECISION
#endif

uniform PRECISION mat4 Global_Proj;

attribute PRECISION vec4 a_vertex;
attribute PRECISION vec4 a_mesh;
attribute PRECISION vec4 a_params;

varying PRECISION vec4 v_mesh;
varying PRECISION vec4 v_params;

void main()
{
  vec4 pos = Global_Proj*a_vertex;    
  gl_Position = pos;
  gl_Position.z = 0.5;
  v_mesh = a_mesh;
  v_params = a_params;
  gl_PointSize = 20.0;
}

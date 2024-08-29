#ifdef GL_ES
#define PRECISION highp
#else
#define PRECISION
#endif

uniform PRECISION mat4 Proj;
/**
 * Minimum viewing extents
 */
uniform PRECISION vec2 viewMin;
/**
 * Maximum viewing extents
 */
uniform PRECISION vec2 viewMax;

attribute PRECISION vec4 a_vertex;
attribute PRECISION vec4 a_mesh;
attribute PRECISION vec4 a_params;

varying PRECISION vec4 v_position;
varying PRECISION vec4 v_mesh;
varying PRECISION vec4 v_params;
//varying vec4 v_color;
void main()
{
  vec4 pos = Proj*a_vertex; /*gl_Vertex;*/ /* gl_ModelViewProjectionMatrix*gl_Vertex;*/
  //pos = pos/pos.w;
  //pos.z = 0.0;
    
  gl_Position = pos;
  gl_Position.z = 0.5;
  /*v_color = a_color; gl_FrontColor = gl_Color; */
  /*gl_FrontColor.r = gl_Color.r + gl_MultiTexCoord0.z;*/
  /* gl_TexCoord[0] = gl_MultiTexCoord0; */
  v_position.xy = (a_vertex.xy - viewMin.xy)/(viewMax.xy - viewMin.xy);
    v_position.zw = vec2(0.0,0.0);
  v_mesh = a_mesh;
  v_params = a_params;
}

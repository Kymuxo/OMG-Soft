#ifdef GL_ES
#define PRECISION highp
#else
#define PRECISION
#endif

/* screen to canvas scaling properties */
uniform PRECISION float halfwidth;
uniform PRECISION float pixelwidth;

/* Pencil colour */
uniform PRECISION vec4 col1;

/*
  Is the parameterisation for this shader it is as follows 
  x = length along curve of current point to end of cross section
  y = cross sectional width in direction of curve of the swept shape
  z = distance from center to left or right depending on it being on the left or right
  w = length along curve to current point
  see mesh.cpp PolyLineSweepShapeWithCoverage(...) for more details
*/
varying PRECISION vec4 v_mesh; 

/* Parameters are { current position on stroke path, width of crossection,  0, 0 } */
varying PRECISION vec4 v_params;

void main()
{
    PRECISION float p = min(abs(v_params.z),1.0);
    PRECISION float h1, h2;
    PRECISION float d = (p*halfwidth - abs(v_mesh.x));
    h1 = smoothstep(0.0,pixelwidth, d);
    h2 = smoothstep(p*halfwidth, p*halfwidth - pixelwidth*1.0, d);
    PRECISION vec4 col = col1;
    col.a = col.a*p;
    col.a = 0.5;//h1*col.a;
    col.rgb = col.rgb*col.a;
    gl_FragColor = col;
}


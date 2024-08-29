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
/**
 * Blending colour
 */
uniform PRECISION vec4 blendCol;
/**
 * Background image to use
 */
uniform sampler2D image;

/*
  Is the parameterisation for this shader it is as follows 
  x = length along curve of current point to end of cross section
  y = cross sectional width in direction of curve of the swept shape
  z = distance from center to left or right depending on it being on the left or right
  w = length along curve to current point
  see mesh.cpp PolyLineSweepShapeWithCoverage(...) for more details
*/
varying PRECISION vec4 v_mesh; 
/**
 * Screen position as [0 1]x[0 1]
 */
varying PRECISION vec4 v_position;

/* Parameters are { current position on stroke path, width of crossection,  0, 0 } */
varying PRECISION vec4 v_params;

void main()
{
    PRECISION float p = min(abs(v_params.z),1.0); //,0.0,1.0);
    PRECISION float h1, h2;
    PRECISION float d = (p*halfwidth - abs(v_mesh.x));
    h1 = smoothstep(0.0,pixelwidth, d);
    h2 = smoothstep(p*halfwidth, p*halfwidth - pixelwidth*1.0, d);
    PRECISION vec4 col = blendCol*texture2D(image,v_position.xy);
    //col.a = col.a*p;
    //col = col1;// + vec4(0.0,0.0,0.0,1.0)*(1.0 - h2);
    col.a = h1;//*col.a;//col1*h;//vec4(col1.r,col1.g,col1.b,h);
    col.rgb = /*v_position.xyy;*/col.rgb*col.a;//*col.a;
    gl_FragColor = col;
}


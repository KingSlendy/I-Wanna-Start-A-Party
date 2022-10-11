//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform vec2 u_origin;
uniform vec2 u_mult;

void main()
{
    vec4 pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    float t = u_origin.x + u_time;
    float d = (pos.y - u_origin.y);
    pos.x += cos(t) * d * u_mult.x;
    pos.y += abs(sin(t)) * d * u_mult.y;
    
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~
//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
	vec4 c = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = c;
}

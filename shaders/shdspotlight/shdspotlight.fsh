varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec2 u_uPosition;
uniform float u_uSize;

float map(float value, float from1, float to1, float from2, float to2) {
	float old_range = to1 - from1;
	
	if (old_range == 0.0) {
	    return from2;
	}

	float new_range = to2 - from2;
	return (((value - from1) * new_range) / old_range) + from2;
}

void main() {
	float dist = distance(v_vPosition, u_uPosition) / u_uSize;
	float alpha = map(dist, 0.0, 0.5, 1.0, 0.0);
    gl_FragColor = vec4(v_vColour.rgb, alpha);
}
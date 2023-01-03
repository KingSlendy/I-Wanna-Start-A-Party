varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	color.rgb = vec3(0.0);
	color.a *= 0.7;
	gl_FragColor = color;
}
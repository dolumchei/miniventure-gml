varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_paletteColor1;
uniform vec4 u_paletteColor2;
uniform vec4 u_paletteColor3;
uniform vec4 u_paletteColor4;

void main()
{
	vec4 source = texture2D(gm_BaseTexture, v_vTexcoord);
	
	float index = source.b;
	vec4 mapped;
	if (index < 0.15)
		mapped = u_paletteColor1;
	else if (index < 0.49)
		mapped = u_paletteColor2;
	else if (index < 0.84)
		mapped = u_paletteColor3;
	else
		mapped = u_paletteColor4;

	gl_FragColor = mapped * v_vColour;
}

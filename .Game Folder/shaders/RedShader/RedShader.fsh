//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float red_alpha;

void main()
{
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    float num = 3.0 * red_alpha;
	float r_ = (gl_FragColor.r + num) / (1.0 + num);
    float g_ = (gl_FragColor.g) / (1.0 + num);
    float b_ = (gl_FragColor.b) / (1.0 + num);
	gl_FragColor.rgb = vec3(r_, g_, b_);
}

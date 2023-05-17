//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float white_alpha;

void main()
{
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    float num = 3.0 * white_alpha;
	float r_ = (gl_FragColor.r + num) / (1.0 + num);
    float g_ = (gl_FragColor.g + num) / (1.0 + num);
    float b_ = (gl_FragColor.b + num) / (1.0 + num);
	gl_FragColor.rgb = vec3(r_, g_, b_);
}

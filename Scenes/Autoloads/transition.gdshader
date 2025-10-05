shader_type canvas_item;

uniform vec4 chroma_key : source_color = vec4(1.0, 0.0, 1.0, 1.0);
uniform float intensity : hint_range(0.0, 1.0) = 0.1;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec4 tex_color = textureLod(screen_texture, SCREEN_UV, 0.0);

	if (tex_color.a > 0.0001) {
		tex_color.rgb /= tex_color.a;
	}
	
	vec3 color_diff = abs(tex_color.rgb - chroma_key.rgb);
	
	float diff_magnitude = length(color_diff);
	
	if (diff_magnitude < intensity) {
		discard;
	}
	
	COLOR = tex_color;
}
shader_type canvas_item;

uniform bool glowing = false;
uniform vec4 glow_color: source_color = vec4(1.0);
uniform float radius = 4.0;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 custom_uv = SCREEN_UV;
	vec4 t_col = texture(SCREEN_TEXTURE, custom_uv);

	vec2 ps = SCREEN_PIXEL_SIZE;

	vec4 b_col = vec4(0.0);
	if (glowing) {
		b_col += texture(SCREEN_TEXTURE, custom_uv + vec2(0.0, -radius) * ps);
		b_col += texture(SCREEN_TEXTURE, custom_uv + vec2(0.0, radius) * ps);
		b_col += texture(SCREEN_TEXTURE, custom_uv + vec2(-radius, 0.0) * ps);
		b_col += texture(SCREEN_TEXTURE, custom_uv + vec2(radius, 0.0) * ps);
		b_col /= 4.0;
		b_col.a *= 1.0 + sin(TIME * PI) / 2.0;
		b_col.rgb = vec3(1.0) * glow_color.rgb;
	}

	COLOR = mix(b_col, t_col, t_col.a);
}

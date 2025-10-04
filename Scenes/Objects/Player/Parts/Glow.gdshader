shader_type canvas_item;

uniform bool glowing = false;
uniform vec4 glow_color: source_color = vec4(1.0);
uniform float radius = 4.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 custom_uv = UV * 1.1 - 0.05;
	vec2 masked_uv = custom_uv;
	if (custom_uv.x < 0.0 || custom_uv.y < 0.0 || custom_uv.y > 1.0 || custom_uv.x > 1.0) {
		masked_uv = vec2(0.0);
	}
	vec4 t_col = texture(TEXTURE, masked_uv);

	vec2 ps = TEXTURE_PIXEL_SIZE;

	vec4 b_col = vec4(0.0);
	if (glowing) {
		b_col += texture(TEXTURE, custom_uv + vec2(0.0, -radius) * ps);
		b_col += texture(TEXTURE, custom_uv + vec2(0.0, radius) * ps);
		b_col += texture(TEXTURE, custom_uv + vec2(-radius, 0.0) * ps);
		b_col += texture(TEXTURE, custom_uv + vec2(radius, 0.0) * ps);
		b_col /= 4.0;
		b_col.a *= 1.0 + sin(TIME * PI) / 2.0;
		b_col.rgb = vec3(1.0) * glow_color.rgb;
	}

	COLOR = mix(b_col, t_col, t_col.a);
}

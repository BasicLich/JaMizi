shader_type canvas_item;

uniform float stroke: hint_range(0.0, 5.0) = 1.0;
uniform vec4 outline_color: hint_color = vec4(0.5, 0.5, 0.5, 1.0);

void fragment()
{
	float w = stroke * 1.0 / float(textureSize(TEXTURE, 0).x);
	float h = stroke * 1.0 / float(textureSize(TEXTURE, 0).y);
	vec4 sprite_color = texture(TEXTURE, UV);
	float alpha = -4.0 * sprite_color.a;
	alpha += texture(TEXTURE, UV + vec2(w, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-w, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -h)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, h)).a;
	vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4( final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
}
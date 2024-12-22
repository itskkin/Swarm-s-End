/*
Blinking glowing red outline shader (based on the Rainbow outline by @Farfalk and @ThePadDev, July 2021)

Apply to canvas items with transparent backgrounds.
Ensure there is enough transparent space around the object for the outline.

CC0 License (but citation is welcome <3)
*/

shader_type canvas_item;

uniform float line_thickness : hint_range(0, 20) = 1.0; // Thickness of the outline
uniform float glow_intensity : hint_range(0.0, 10.0) = 2.0; // Maximum glow intensity
uniform float blink_speed : hint_range(0.1, 10.0) = 2.0; // Speed of the blinking effect

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;

	// Calculate the outline alpha by sampling around the texture
	float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);

	// Compute the blinking intensity using a sine wave
	float blink_intensity = abs(sin(TIME * blink_speed)) * glow_intensity;

	// Define the blinking red color for the outline
	vec4 red_glow = vec4(1.0, 0.0, 0.0, 1.0) * blink_intensity;

	// Sample the base texture color
	vec4 color = texture(TEXTURE, UV);

	// Combine the base color and the blinking glowing outline
	COLOR = mix(color, red_glow, outline - color.a);
}

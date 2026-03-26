shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(0.4, 0.38, 0.35, 1.0);
uniform float brightness = 0.85;

// Declare array of bulb positions (set in Inspector or script)
uniform vec2 bulb_pos[3];

uniform float cone_angle = 0.5;   // radians
uniform float cone_length = 0.6;  // how far the beam extends
uniform vec4 bulb_color : source_color = vec4(1.0, 0.9, 0.7, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    tex_color.rgb *= tint_color.rgb * brightness;

    // Loop through each bulb
    for (int i = 0; i < 3; i++) {
        vec2 dir = UV - bulb_pos[i];

        if (dir.y > 0.0) { // only pixels below bulb
            float dist = length(dir);
            vec2 ndir = normalize(dir);
            vec2 down = vec2(0.0, 1.0);
            float angle = acos(dot(ndir, down));

            if (angle < cone_angle && dist < cone_length) {
                float intensity = (1.0 - dist / cone_length) * (1.0 - angle / cone_angle);
                tex_color.rgb += bulb_color.rgb * intensity * 0.8;
            }
        }
    }

    COLOR = tex_color;
}

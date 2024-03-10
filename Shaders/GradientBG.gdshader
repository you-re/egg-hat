shader_type canvas_item;
render_mode skip_vertex_transform;

uniform vec3 col1;
uniform vec3 col2;
uniform float alpha = 0.5;

void vertex() {
    VERTEX = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	UV = VERTEX;
}

void fragment() {
	vec3 col = mix(col1, col2, UV.x);
	COLOR = vec4(col, alpha); //vec4(col, alpha);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

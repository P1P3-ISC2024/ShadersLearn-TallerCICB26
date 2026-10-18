/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

Crea el efecto de agua en un area correspondiente al Sprite.
*/
shader_type canvas_item;

/* 
El siguiente parametro no aparece en el inspector,
ya que se rellena automaticamente con la hint_screen_texture,
por lo que se podría decir que es un parametro del proceso de renderizado.
filter_nearest -> toma el color del píxel exacto más cercano sin interpolar ni suavizar bordes.
*/
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float desplazamiento =
		0.01*sin(UV.y*20.0+ TIME*4.0);	// Calcula el desplazamiento según la pos 'y' de UV.
	//vec3 color_1 = vec3(0.6,0.05,0);	// si quisieramos poner un color en las crestas.
	vec3 color_2 = vec3(0.08,0.01,0);	// Color que modifica el aspecto del fondo.
	COLOR.rgba = texture(screen_texture,// Toma el colo de la escena.
	SCREEN_UV.xy + desplazamiento		// Mapa UV pero en pantalla + desplazamiento.
	);//*/
	// Usando UV y texture.
	/*COLOR.rgba = texture(TEXTURE,
	UV.xy + desplazamiento
	);//*/
	COLOR.rgb -= color_2;				// Atenua el color.
	//COLOR.rgb -= mix(color_1,color_2, abs(sin(UV.y*20.0+ TIME*4.0)) ); // Crestas de otro color.
}
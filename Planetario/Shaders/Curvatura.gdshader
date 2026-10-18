/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

Shader para aplicar un efecto de curvatura estilo agujero negro en texturas.
*/
shader_type canvas_item;

// Parametros...
uniform vec2 pos = vec2(0.5,0.5);	// Poisición del agujero.
uniform float radio_1 = 0.008;		// Radio del objeto negro.
uniform float radio_2 = 0.5;		// Radio de los objetos del agujero.
uniform vec2 centro = vec2(576,324);// Centro de la escena.
// Textura de fondo antes del renderizado del shader...
uniform sampler2D screen: hint_screen_texture, repeat_disable, filter_nearest;


void fragment() {
	// Calcular las posiciones donde se realiza el efecto...
	// Verifico el tamaño de la textura del sprite al que se aplica el shader...
	float relacion = TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;	// (1/TAM_x)/(1/TAM_y) = TAM_y/TAM_x 
	vec2 dist = (UV-pos) / vec2(relacion,1.0);		// Calculo al distancia del pixel.
	// Supongamos que consideramos la posición en la camara de la escena...
	//float relacion = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;	// Relación de aspecto de la textura SCREEN
	//vec2 dist = (pos - SCREEN_UV) / vec2(relacion,1.0); //*/		// Distancia predicha.
	
	// Para la deformación con el logaritmo...
	float x;						// Ordenada de la función de deformación
	vec2 defor;						// Mapa UV resultado de la deformación.
	
	// Dibuja un circulo negro...
	if( length(dist) <= radio_1 ){
		COLOR.rgba = vec4(0,0,0,1);
	}// Aplica la deformación...
	else if( length(dist) <= radio_2 ){								// <- Distancia de la textura local.
		// Para saber la posición del pixel respecto al centro...
		x = (1.0/radio_2) * length(dist);							// Para que x valga 1 cuando dist = radio_2
		vec2 centro_screen_uv = centro*SCREEN_PIXEL_SIZE;			// Centro del agujero en la textura SCREEN
		//vec2 centro_screen_uv = (FRAGCOORD.xy - vec2(0,324.0))*SCREEN_PIXEL_SIZE;	// FRAGCOORD contiene la posición en la pantalla (en píxeles)
		// Aplico la deformación...
		defor = mix(SCREEN_UV,centro_screen_uv,-log(x));			// Estiro la imagen.
		defor -= centro_screen_uv;	// Tranformo, ahora el centro es (0,0)
		defor = vec2(defor.x*cos(log(x))-defor.y*sin(log(x)),defor.x*sin(log(x))+defor.y*cos(log(x)));	// Roto la imagen. de acuerdo a log(x)
		defor += centro_screen_uv;	// Vuelvo a aplicar la transformación, ahora el centro es (0.5,0.5)
		// Aplico el cambio de textura en esos pixeles...
		COLOR = texture(screen,defor);
	}
	else{// Vuelve transparente la textura...
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

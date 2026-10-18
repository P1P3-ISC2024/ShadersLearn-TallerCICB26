/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

Este programa le da el aspecto de agua o mar a un plano 3D.
*/

shader_type spatial;

// Experimento.
//varying flat vec3 flat_color;     // No se interpola
//varying smooth vec3 smooth_color; // Se interpola suavemente
// Oleaje.
uniform vec2 frec = vec2(1);		// Frecuencia de los componentes del oleaje.
uniform vec2 vel = vec2(1);			// Velocidad con la que se desplazan las olas.
uniform vec2 alt = vec2(1);			// Altura del oleaje.
// Colores.
uniform vec4 color_deep:source_color;				// Color de la superficie del fondo del mar.
uniform vec4 color_surface:source_color;			// Color de los objetos conforme se acercan a la superficie.
// Texturas.
	// Imagen en pantalla...
uniform sampler2D screen: hint_screen_texture, repeat_disable, filter_nearest;
	// Información de profundidad...
uniform sampler2D deep: hint_depth_texture, repeat_disable, filter_nearest;
// Normales.
uniform sampler2D noise;			// Textura de ruido para mapa de normales.
uniform float des_1: hint_range(0,0.1);				// Desplazamiento del ruido.
uniform float des_2: hint_range(0,0.1);				// Desplazamiento para el segundo ruido.
// Reflejos.
uniform float emition:hint_range(0.5,1.0) = 0.86;	// Emision de color del agua.
uniform float rugosidad:hint_range(0.0, 1.0,0.1);	// Textura de rugosidad.
uniform float metalicidad:hint_range(0.0, 1.0,0.1);	// Comportamiento del color con la luz.
// Espuma.
uniform sampler2D espuma;			// Textura de espuma.
uniform float alt_esp:hint_range(0.0, 1.0) = 0.8;	// Altura a la que aparece.
uniform float i_espuma:hint_range(0.0, 1.0) = 0.5;	// Intencidad de la espuma.
varying smooth float vertex_y;		// Guarda la altura esperada de la ola en un nodo.

float wave(vec3 pos){
	// Componente 1...
	//return alt.x*sin(pos.x*frec.x+TIME*vel.x);
	// Componente 2...
	//return alt.y*cos( (pos.z+2.0*pos.x) * frec.y+TIME*vel.y);
	// Función...
	return alt.x*sin(pos.x*frec.x+TIME*vel.x) +
		alt.y*cos( (-pos.z+2.0*pos.x) * frec.y+TIME*vel.y);
}

void vertex() {
	// Experimento...
	//VERTEX = VERTEX + vec3(0,sin(VERTEX.x),0);	// Jugamos con la altura del vertice.
	// Asignamos colores distintos a cada vértice
    //flat_color = VERTEX;			  // Color escalonado según Vertex.
    //smooth_color = VERTEX;		  // Color suavizado según el pixel y el Vertex.
	
	// Realizamos el oleaje...
	VERTEX.y = wave(VERTEX);
	
	// Para la espuma...
	vertex_y = VERTEX.y;	// porque VERTEX pasa por una transformación.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// Dibujamos ambos para comparar
    //ALBEDO = mix(flat_color, smooth_color, 0.8);
	
	// Manejar la profundidad...
	vec3 depth = texture(deep,SCREEN_UV).rgb;		// Enrealidad solo sirve el canal r.
	/* para comparar alturas...
	ALBEDO = texture(screen,SCREEN_UV).rgb;
	if(depth.x <= 0.01){
		ALBEDO *= color_deep.rgb;
	}
	else{
		ALBEDO *= color_surface.rgb;
	}
	ALPHA = color_deep.a;*/
	
	// transición suave del color...
	ALBEDO = texture(screen,SCREEN_UV).rgb;			// Tomamos la imagen de fondo.
	float d = clamp(depth.x*100.,0,1.);				// Escalamos y restrigimos los valores de la profundidad.
	vec4 color = mix(color_deep,color_surface,d);	// Depende de la profundidad, tomará un color u otro.
	float alph = mix(color_deep.a,color_surface.a,d);		// Lo mismo para la transparencia.
	ALBEDO = mix(color.rgb,color.rgb*ALBEDO,d);		// Incluimos que tanto se ve de fondo.
	ALPHA = alph;					// aplicamos la transparencia.
	
	// Mapa de normales...
	vec3 ruido_1 = texture(noise,UV+TIME*des_1).rgb;// Desplazamos y convertimos la textura.
	vec3 ruido_2 = texture(noise,UV-TIME*des_2).rgb;// Desplazamos y convertimos la textura.
	NORMAL = normalize(ruido_1 + ruido_2);			// Superponemos los relieves y lo normalizamos.
	
	// Reflejos...
	if( dot(NORMAL,vec3(0,0,1.)) > emition ){		// Si el normal apunta hacia arriba.
		EMISSION = vec3(10.);		// Realiza destellos.
	}
	ROUGHNESS = rugosidad;			// Aplicamos nivel de rugosidad.
	METALLIC = metalicidad;			// Aplicamos nivel de metalicidad.
	
	// ESPUMA ...
	vec3 text_espuma = texture(espuma,UV+TIME*des_2).rgb;	// Desplazo y obtengo la textura de la espuma.
	/* //Experimento sobre altura.
	// quita wave y deja VERTEX.y y mira lo que pasa.
	if(wave(VERTEX) > alt.x*alt_esp){
	//if(VERTEX.y > alt.x*alt_esp){
	ALBEDO += i_espuma;
	}
	//*/
	// xi es la altura, yi el nivel de expuma.
	float m = (1.)/( (alt.x+alt.y)-alt.x*alt_esp);	// calculando la pendiente de la recta que pasa por el max y min.
	//                     ^MAX			^MIN
	float b = -m*(alt.x+alt.y)+1.; // b = m*xi - yi
	vec3 suavizado = clamp(mix(vec3(0),text_espuma,vertex_y*m+b),0,1.);	// clamp porque el valor de la recta se puede pasar.
	//											   ^ Valor actual de la superficie.
	ALBEDO += suavizado*i_espuma;
}

/*void light() {
	
}*/

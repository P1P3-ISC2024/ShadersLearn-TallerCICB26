/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

Este programa juega con los reflejos en un sprite a partir de un mapa de alturas.
*/
shader_type canvas_item;

// Parametros del mapa de normales.
uniform float fuerza :hint_range(0.0,1.0) = 0.5;	// Fuerza del mapa de normal entre 0 y 1.
varying vec3 normal;			// Guarda el vector normal a la superficie en un pixel.

void fragment(){
	// Obtengo el vector normal de acuerdo a un mapa de alturas...
	float alt, par_x, par_y;	// Altura y pendientes en X y Y.
	alt = texture(TEXTURE,UV).r;// Obtengo la altura del pixel actual.
	// Reviso el pixel de la derecha...
	par_x = texture(TEXTURE,UV + vec2(TEXTURE_PIXEL_SIZE.x,0)).r;
	// Reviso el pixel de arriba...
	par_y = texture(TEXTURE,UV - vec2(0,TEXTURE_PIXEL_SIZE.y)).r;
	// Comparo las alturas...
	normal = vec3(alt-par_x,alt-par_y,fuerza);
	
	// Guardar la normal...
	//normal = normalize(normal);	// Sin guardar en un mapa de normales.
	normal = normalize(normal)/2.0 + 0.5;	// Usando mapa transformo para que el color vaya de 0 a 1, donde 0 es -1. y 0.5 es 0.
	NORMAL_MAP = normal;	// con mapa de normales
	
	// Textura...
	//COLOR.rgb = normal;			// Para visualizar la textura.
	COLOR.rgb = vec3(0.1,0.1,0.1);	// Fondo oscuro.
}

void light(){
	float reflejo;					// Intensidad de luz que debe reflejar.
	
	// Calculo la luz en una superficie tal que se ve el mapa...
	//LIGHT = vec4(COLOR.rgb*LIGHT_COLOR.rgb*LIGHT_ENERGY*normal,COLOR.a);
	
	// Calculo la proyección de luz, considerando la normal...
	//reflejo = -dot(normal,LIGHT_DIRECTION);
	//reflejo = -clamp(dot(normal,LIGHT_DIRECTION),-1.0,0.0);
	// La luz choca con las normales negativas. 	^
	
	// Usando la textura o mapa NORMAL...
	//vec3 trans = (normal - 0.5) *2.0;		// usando normal y transformandola.
	//reflejo = -clamp(dot(trans,LIGHT_DIRECTION),-1.0,0.0);
	// Usando NORMAL...
	reflejo = -clamp(dot(NORMAL,LIGHT_DIRECTION),-1.0,0.0);
	
	// Indico la cantidad de luz a procesar.
	LIGHT = vec4(COLOR.rgb*LIGHT_COLOR.rgb*LIGHT_ENERGY*reflejo,COLOR.a);
}

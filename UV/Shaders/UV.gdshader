/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

El objetivo de este programa es conocer el funcionamiento base de un fragment y los mapas UV.
*/
shader_type canvas_item;

void fragment() {
	COLOR.rgb = vec3(0,0,0);				// Cambia el color final.
	//COLOR.rgba = vec4(0,0,0,1.0);			// Transparencia.
	//COLOR.rgba = vec4(UV.xy,0,1.0);		// Como se ve un mapa UV.
	//COLOR.grba = vec4(UV.xy,0,1.0);		// Podemos cambiar el orden de los elemetnos.
	//COLOR.xw = UV.xy; 					// COLOR.ra; xyzw = rgba
	//COLOR.rgb = 1.0 - COLOR.rgb;			// Se invierten los colores.
	//COLOR.rgba = vec4(UV.xy+0.5,0,1.0);	// Podemos desplazar un mapa UV.
	//COLOR.rgba = texture(TEXTURE,UV.xy + 0.5); 	//TEXTURE es un sampler2D
	//UV.xy += 0.5;							// porque UV es constante
	//COLOR.rgba = texture(TEXTURE,vec2(0.5,0.5));	// Toma el color del pixel del centro.
	/*
	Con TEXTURE accedo a la textura asignada y no al color del objeto.
	
	¿Porque no se puede acceder al valor del COLOR en otra posición?
	R: Porque cada unidad maneja su propia variable de COLOR,
	la comunicación entre unidades, así como la gestión de recursos compartidos es inviable.
	*/
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

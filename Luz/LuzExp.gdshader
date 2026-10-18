/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

En este programa se muestran ejemplos sobre como manejar la luz.
*/
shader_type canvas_item;

//void fragment(){
	//COLOR.rgb = vec3(0);
//}

void light() {
	// Cambiar la intencidad del color con la luz...
	//LIGHT.rgb = COLOR.rgb*1.0;				// Color de sprite.	
	//LIGHT.a = 1.0;							// Transparencia o intencidad de la luz.
	//LIGHT.a = COLOR.a;						// Preserva la intencidad según la transparencia del material.
	
	// Puede superponer texturas...
	//LIGHT = texture(TEXTURE,UV+0.5);			// Adelanta la imagen a la mitad.
	// Manejar la intencidad de la luz del objeto...
	//LIGHT = LIGHT_COLOR * LIGHT_ENERGY;		// Cambia al mover Energy de la luz.
	
	// Como funciona la luz por defecto...
	//LIGHT = vec4(COLOR.rgb*LIGHT_COLOR.rgb*LIGHT_ENERGY,COLOR.a);
	
	// Texturas UV sobre la luz...
	//LIGHT = vec4(UV,0,1.0);					// La textura UV del sprite.
	//LIGHT = vec4(LIGHT_DIRECTION,1.0);		// Textura de la dirección.
	// El color representa un vector normalizado que apunta hacia donde está la fuente de luz. 
	// rgb = (x,y,0). Usa BlendMod en Mix...
	// La luz solo aparece en una dirección sobre x...
	LIGHT = vec4(LIGHT_DIRECTION,1.0) * step(-0.5,LIGHT_DIRECTION.x);
	// La función step = LIGHT_DIRECTION.x > -0.5? 1:0;
}

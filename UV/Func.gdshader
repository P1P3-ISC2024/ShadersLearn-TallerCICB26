/*
Progamador: Felipe de Jesús Martínez Alfaro.
Taller: Desarrollo de shaders para viedojuegos.
Lugar: CIC IPN.
2026

El objetivo de este programa es conocer algunas funciones base de los shaders.
*/
shader_type canvas_item;

// Parametros...
uniform float brillo = 1.0;		// Parametro flotante que indica el brillo de la textura.
uniform vec4 color:source_color;// Tambien podemos poner un color como parametro y se guarda en un vec4.
// source_color sirve para que en el inspector podamos editar un color.

void fragment() {
	COLOR *= brillo;			// Al multiplicar hacemos más o menos intenso y claro un color.
	//COLOR += color;			// Le sumamos un color.
	//COLOR *= color;			// Así funciona Modulate o Self modulate.
	//COLOR = texture(TEXTURE,vec2(UV.x,sin(UV.y*PI*2.0)));	// Función seno.
	//COLOR.rgb = mix(COLOR.rgb,1.0-COLOR.rgb,UV.y);		// Función Lerp, un punto UV.y intermedio entre el color y su negativo.
	//COLOR = texture(TEXTURE,fract(UV*2.0)); 				// Devuelve las decimas
	//COLOR = texture(TEXTURE,mod(UV*2.0,1.0));				// Es posible aplicar un modulo flotante.
	//COLOR = floor(COLOR*1.5+0.0);							// floor Redondea al numero entero menor más cercano.
}

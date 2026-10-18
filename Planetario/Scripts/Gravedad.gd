"""
Programador: Felipe de Jesús

Nodo padre que regula el funcionamiento de los cuerpos celestes.

						# 1.
										# 2.
														# 3.
																		# 4.
																				# 5.
"""
extends Node

@export var planetas:Array[RigidBody2D] = []			# Nodos cuerpoCeleste.
@export var g:float = 10000;			# Constante gravitacional.

# Ecuación de la gravedad.
func grav(m1,m2,r):
	return (g*m1*m2)/r**2;
	
# Calcula la influencia gravitacional total para un cuerpo.
func calcGrav(obj:Node2D):
	var sum = Vector2.ZERO;				# Inicia la sumatoria en ceros.
	var distancia:Vector2				# Guarda la distancia entre dos vectores.
	# Realiza la suma de fuerzas...
	for p in planetas:
		if obj != p:	# Un cuerpo no se influencia así mismo.
			distancia = (-obj.position + p.position)	# Obtengo la distancia.
			# Suma el vector F = escala*dirección = g*d.normalized
			sum += grav(obj.mass,p.mass,distancia.length())*distancia.normalized()
		pass;
	return sum;			# Retorna un vector que indica el total.

# Cuado se calculen las fisicas...
func _physics_process(delta: float) -> void:
	for obj in planetas:# Para cada planera.
		obj.apply_force(calcGrav(obj)*delta)			# Calcular su influencia.
		# delta nos ayuda a tener un resultado coherente,
		# sin impotar la capacidad de procesamiento de la PC.
		# delta = 1/framesPorSegundo.
	return;

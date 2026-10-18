"""
Programador: Felipe de Jesús

Le indica al shader que lleva su posición global actual.

						# 1.
										# 2.
														# 3.
																		# 4.
																				# 5.
"""
extends Sprite2D

# Para cada frame.
func _process(delta: float) -> void:
	if self.material is ShaderMaterial:	# Corrobora si tiene un material.
		# En caso afirmativo modifica el parámetro llamado "centro".
		self.material.set_shader_parameter("centro",self.global_position)
		pass;
	return;

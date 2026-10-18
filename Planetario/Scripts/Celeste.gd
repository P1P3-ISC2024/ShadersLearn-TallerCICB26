"""
Programador: Felipe de Jesús

Inicializa el objeto con un impulso.

						# 1.
										# 2.
														# 3.
																		# 4.
																				# 5.
"""
extends RigidBody2D

@export var initial_force:Vector2 = Vector2(100,0)

func _ready() -> void:
	self.apply_impulse(initial_force)

extends Node

var enemy: CharacterBody2D = null
var estado_actual: String = "patrullar"

func setup(_enemy):
	enemy = _enemy

func update(_delta):
	if enemy == null: return
		
	match estado_actual:
		"patrullar":
			_logica_patrullar()
		"perseguir":
			_logica_perseguir()
	
	_actualizar_animacion()

func cambiar_estado(nuevo_estado: String):
	if estado_actual == nuevo_estado: return
	estado_actual = nuevo_estado

func _logica_patrullar():
	if enemy.puntos_patrulla.is_empty():
		enemy.velocity.x = 0
		return

	var objetivo = enemy.puntos_patrulla[enemy.punto_actual]
	var direccion = (objetivo - enemy.global_position).normalized()
	enemy.velocity.x = direccion.x * enemy.velocidad

	if enemy.global_position.distance_to(objetivo) < 20:
		enemy.punto_actual = (enemy.punto_actual + 1) % enemy.puntos_patrulla.size()

func _logica_perseguir():
	if enemy.jugador == null:
		enemy.jugador = get_tree().get_first_node_in_group("player")
		return

	var direccion = (enemy.jugador.global_position - enemy.global_position).normalized()
	
	enemy.velocity.x = direccion.x * (enemy.velocidad * 1.3)

func _actualizar_animacion():
	var anim = enemy.get_node("AnimatedSprite2D")
	if abs(enemy.velocity.x) < 5:
		anim.play("idleenemy")
	else:
		anim.play("d" if enemy.velocity.x > 0 else "i")

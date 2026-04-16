extends Node

@onready var player: CharacterBody2D = self.owner

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

enum STATE {
	idle,
	derecha,
	izquierda,
	saltando,
	cayendo
}

var current_state = STATE.idle


func _physics_process(delta):

	if Input.is_action_just_pressed("arriba") and player.is_on_floor():
		player.velocity.y = player.salto

	_aplicar_gravedad(delta)
	_cambiar_estado()
	_aplicar_animacion()

	player.move_and_slide()


func _cambiar_estado():

	var direction = Input.get_axis("izq", "der")

	if not player.is_on_floor():
		if player.velocity.y < 0:
			current_state = STATE.saltando
		else:
			current_state = STATE.cayendo
		return

	if direction > 0:
		current_state = STATE.derecha
	elif direction < 0:
		current_state = STATE.izquierda
	else:
		current_state = STATE.idle


func _aplicar_animacion():

	match current_state:

		STATE.idle:
			player.velocity.x = move_toward(player.velocity.x, 0, player.friccion)
			if player.anim.animation != "idle":
				player.anim.play("idle")

		STATE.derecha:
			player.velocity.x = player.velocidad
			if player.anim.animation != "wd":
				player.anim.play("wd")

		STATE.izquierda:
			player.velocity.x = -player.velocidad
			if player.anim.animation != "wi":
				player.anim.play("wi")

		STATE.saltando:
			if player.anim.animation != "saltito":
				player.anim.play("saltito")

		STATE.cayendo:
			if player.anim.animation != "caida":
				player.anim.play("caida")


func _aplicar_gravedad(delta):
	player.velocity.y += gravity * delta

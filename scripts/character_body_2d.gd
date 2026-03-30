extends CharacterBody2D

@export var velocidad = 200
@export var salto = -350
@export var gravedad = 900

@export var friccion = 100
@export var aceleracion = 400

var saltosRestantes = 2

@onready var anim = $AnimatedSprite2D


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravedad * delta
	else:
		saltosRestantes = 2

	var direction = Input.get_axis("izq", "der")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * velocidad, aceleracion * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friccion * delta)

	if Input.is_action_just_pressed("enter") and saltosRestantes > 0:
		velocity.y = salto
		saltosRestantes -= 1

	move_and_slide()

	var nueva_animacion = "idle"

	if velocity.x > 0:
		nueva_animacion = "wd"
	elif velocity.x < 0:
		nueva_animacion = "wi"

	if anim.animation != nueva_animacion:
		anim.play(nueva_animacion)

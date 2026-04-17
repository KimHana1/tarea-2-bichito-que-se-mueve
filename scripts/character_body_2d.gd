extends CharacterBody2D
class_name Player

@export var velocidad = 100
@export var salto = -250			
@export var friccion = 200


@onready var anim = $AnimatedSprite2D

func recibir_danio():
	print("Me hicieron daño")

func _physics_process(delta):
	move_and_slide()

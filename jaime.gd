extends CharacterBody2D

@export var velocidad: float = 100
@export var puntos_patrulla: Array[Vector2] = []
@export var punto_actual: int = 0
@export var detection_range: float = 300 

var jugador: Node2D = null 

@onready var state_machine = $stateMachine

func _ready():
	state_machine.setup(self)
	
	var nodos = get_tree().get_nodes_in_group("player")
	if nodos.size() > 0:
		jugador = nodos[0]
		print("jugador ", jugador.name)
	else:
		jugador = get_parent().find_child("player", true, false)
		if jugador:
			print(" encontrado ", jugador.name)
		else:
			print(" ERROR")

func _physics_process(_delta):
	if jugador != null:
		var dist = global_position.distance_to(jugador.global_position)
		
		if dist < detection_range:
			if state_machine.estado_actual != "perseguir":
				print("Cambiando a PERSEGUIR")
				state_machine.cambiar_estado("perseguir")
		else:
			if state_machine.estado_actual == "perseguir":
				print("volviendo a PATRULLAR")
				state_machine.cambiar_estado("patrullar")
	
	state_machine.update(_delta)
	move_and_slide()

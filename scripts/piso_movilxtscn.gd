extends AnimatableBody2D

@export var velocidad := 100
@export var distancia := 200

var posicionInicial
var direccion := 1

func _ready():
	posicionInicial = position

func _physics_process(delta):
	position.x += velocidad * direccion * delta
	
	if position.x > posicionInicial.x + distancia:
		direccion = -1
	elif position.x < posicionInicial.x - distancia:
		direccion = 1

extends AnimatableBody2D
@export var velocidad := 100
@export var distancia := 200
var posicionInicial
var direccion := 1
func _ready():
	posicionInicial = position
func _physics_process(delta):
	position.y += velocidad * direccion * delta
	if position.y > posicionInicial.y + distancia:
		direccion = -1
	elif position.y < posicionInicial.y - distancia:
		direccion = 1

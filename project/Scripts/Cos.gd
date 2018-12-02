extends Node2D

# class member variables go here, for example:
# var a = 2
var pos_anterior = Vector2()
var rotacio_objectiu
var diferencia
var maxim_rota = int(90)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	diferencia = global_position.x - pos_anterior.x
	pos_anterior = global_position
	if (diferencia > 2):
		rotacio_objectiu = int(deg2rad(diferencia)) % maxim_rota
	elif (diferencia < 2):
		rotacio_objectiu = int(deg2rad(diferencia)) % maxim_rota
	$Sprite.rotation = lerp($Sprite.rotation, rotacio_objectiu, 0.3)

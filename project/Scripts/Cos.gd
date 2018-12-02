extends Node2D

# class member variables go here, for example:
# var a = 2
var pos_anterior = Vector2()
var rotacio_objectiu
var diferencia
var maxim_rota = int(360)
var frame_actual = 0
var max_frames = 4
var time = 0
var array_frames = [0, 1, 0, 2]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	diferencia = global_position.x - pos_anterior.x
	pos_anterior = global_position
	if (diferencia > 2):
		rotacio_objectiu = int(deg2rad(diferencia)) % maxim_rota
		$Sprite.rotation = lerp($Sprite.rotation, rotacio_objectiu, 0.3)
	elif (diferencia < 2):
		rotacio_objectiu = int(deg2rad(diferencia)) % maxim_rota
		$Sprite.rotation = lerp($Sprite.rotation, rotacio_objectiu, 0.3)
	else:
		rotacio_objectiu = 0;
		$Sprite.rotation = lerp($Sprite.rotation, rotacio_objectiu, 0.5)
		print($Sprite.rotation)
func avancar_frame():
	if (time > 1):
		time = 0
		var frame_mostrar
		if (frame_actual < max_frames):
			frame_mostrar = array_frames[frame_actual];
			frame_actual += 1
		else:
			frame_actual = 0
			frame_mostrar = 0
		$Sprite.frame = frame_mostrar
	else:
		time += 1

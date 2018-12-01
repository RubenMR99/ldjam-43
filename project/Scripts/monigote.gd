extends KinematicBody2D

var asobre = false
var clicant = false
var clicant_ant = false
var deixat_anar = false
var target = Vector2()
var velocity = Vector2()
var scale_d = Vector2(1,1)
var scale_1 = Vector2(2,2)
var scale_2 = Vector2(3,3)
var next_scale = Vector2()
var pos_inicial = Vector2()

#func _input(event):
#	if (event.is_pressed()):
#		click = true
#		print("click")
#	else:
#		print("no click")
#		click = false

func _on_KinematicBody2D_mouse_entered():
	print("entra")
	asobre = true
	clicant_ant = false


func _on_KinematicBody2D_mouse_exited():
	print("fora")
	if (not clicant):
		asobre = false

func _physics_process(delta):
	clicant = Input.is_action_pressed("click")
	if (asobre and !clicant_ant):
		next_scale = scale_1
	else:
		next_scale = scale_d
	if (asobre and clicant):
		position = get_global_mouse_position()
		next_scale = scale_2
		clicant_ant = true
	elif(asobre and clicant_ant):
		deixat_anar = true
		print("has deixat anar")
	if (deixat_anar):
#		while(position.y != pos_inicial.y):
#			position.y = lerp(position.y, pos_inicial.y, 0.2);
#			position.x = lerp(position.x, pos_inicial.x, 0.2);
		position = pos_inicial
		deixat_anar = false;
	scale.y = lerp(scale.y, next_scale.y, 0.2);
	scale.x = lerp(scale.x, next_scale.x, 0.2);
	if (not clicant):
		pos_inicial = position
	print(pos_inicial)
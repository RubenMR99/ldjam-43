extends KinematicBody2D

var movent = true
var asobre = false
var clicant = false
var clicant_ant = false
var deixat_anar = false
var entra_deixar = false
var target = Vector2()
var velocity = Vector2()
var scale_d = Vector2(1,1)
var scale_1 = Vector2(2,2)
var scale_2 = Vector2(3,3)
var next_scale = Vector2()
var pos_inicial = Vector2()
var pos_calderon = Vector2()

func _on_KinematicBody2D_mouse_entered():
	asobre = true
	clicant_ant = false


func _on_KinematicBody2D_mouse_exited():
	if (not clicant):
		asobre = false

func _physics_process(delta):
	clicant = Input.is_action_pressed("click")
	if (asobre and !clicant_ant):
		next_scale = scale_1
	else:
		next_scale = scale_d

	if (asobre and clicant):
		agafar()
		clicant_ant = true
	elif(asobre and clicant_ant):
		deixat_anar = true
	
	if (deixat_anar and not entra_deixar):
		deixar_anar()
	elif(entra_deixar and not clicant):
		eliminar()
	
	scale.y = lerp(scale.y, next_scale.y, 0.2);
	scale.x = lerp(scale.x, next_scale.x, 0.2);
	
	if (movent):
		pos_inicial = position
		position.y = position.y + 1

func agafar():
	position = get_global_mouse_position()
	next_scale = scale_2

func deixar_anar():
	position.y = lerp(position.y, pos_inicial.y, 0.1);
	position.x = lerp(position.x, pos_inicial.x, 0.1);
	#position = pos_inicial
	if(position.y  == pos_inicial.y):
		deixat_anar = false;

func eliminar():
	if (not clicant):
		print("sweet spot")
		queue_free()
		entra_deixar = false
		GlobalVar.contador_personas -= 1
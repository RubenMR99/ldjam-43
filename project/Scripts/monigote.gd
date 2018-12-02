extends KinematicBody2D

var movent = true
var asobre = false
var clicant = false
var clicant_ant = false
var deixat_anar = false
var entra_deixar = false
var es_pot_agafar = false
var morir = false

var valor = 15;
var tipus;
var stage = 0;

var target = Vector2()
var pos_anterior = Vector2()
var scale_d = Vector2(1,1)
var scale_1 = Vector2(2,2)
var scale_2 = Vector2(3,3)
var next_scale = Vector2()
var pos_inicial = Vector2()
var pos_calderon = Vector2()

const p_1 = Vector2(0,550)
const p_2 = Vector2(384,0)
const p_3 = Vector2(0,690)
const p_4 = Vector2(896,0)

func _ready():
	var n_aleatori = randi() % 2
	$Cap.frame = n_aleatori

func asignar(tipus_n):
	tipus = tipus_n

func _on_KinematicBody2D_mouse_entered():
	asobre = true
	clicant_ant = false


func _on_KinematicBody2D_mouse_exited():
	if (not clicant):
		asobre = false

func _physics_process(delta):
	#rotation += 20
	pos_anterior = position
	clicant = Input.is_action_pressed("click")
	es_pot_agafar = get_parent().comp_agafar(self)
	if (!morir):
		if (asobre and !clicant_ant and es_pot_agafar):
			next_scale = scale_1
			z_index = 0
		else:
			next_scale = scale_d
			z_index = 0
	
		if (asobre and clicant and es_pot_agafar):
			agafar()
		elif(asobre and clicant_ant):
			deixat_anar = true
		if (deixat_anar and not entra_deixar):
			deixar_anar()
		elif(entra_deixar and not clicant and deixat_anar):
			eliminar()
		
		scale.y = lerp(scale.y, next_scale.y, 0.2);
		scale.x = lerp(scale.x, next_scale.x, 0.2);
		
		if (movent and !get_parent().stop):
			position = guia(position)
			pos_inicial = position
		elif (!get_parent().stop):
			pos_inicial = guia(pos_inicial)
	else:
		scale.y = lerp(scale.y, 0, 0.2);
		scale.x = lerp(scale.x, 0, 0.2);
		position.y = lerp(position.y, 736, 0.1);
		position.x = lerp(position.x, 1632, 0.1);
		z_index = 10
		
		if (scale.y == 0):
			queue_free()
			get_parent().stop_sang()
func guia(posicio_actual):
	if (posicio_actual.y < p_1.y and stage == 0):
		posicio_actual.y += 3
		if posicio_actual.y >= p_1.y:
			stage = 1
	elif (stage == 1):
		posicio_actual.x -= 2
		if posicio_actual.x <= p_2.x:
			stage = 2
	elif (stage == 2):
		posicio_actual.x -= 2
		posicio_actual.y += 2
		if posicio_actual.y >= p_3.y:
			stage = 3
	elif (stage == 3):
		posicio_actual.x += 2
		if (posicio_actual.x >= p_4.x):
			stage = 4
	elif (stage == 4):
		get_parent().stop = true;
	return posicio_actual

func agafar():
	get_parent().agafar(self)
	movent = false;
	position = get_global_mouse_position()
	next_scale = scale_2
	z_index = 10
	clicant_ant = true
	$Cos.avancar_frame()

func deixar_anar():
	position.y = lerp(position.y, pos_inicial.y, 0.1);
	position.x = lerp(position.x, pos_inicial.x, 0.1);
	if(abs(position.y - pos_inicial.y) < 5):
		position = pos_inicial
		deixat_anar = false;
		movent = true
		get_parent().deixar_anar()

func entrada_caldero():
	entra_deixar = true

func sortida_caldero():
	entra_deixar = false

func eliminar():
	if (tipus == "MEAT"):
		GlobalVar.meat_rec += valor
		print(GlobalVar.meat_rec)
	elif (tipus == "BLOOD"):
		GlobalVar.meat_rec += valor
		print(GlobalVar.blood_rec)
	GlobalVar.contador_personas -= 1
	get_parent().stop = false;
	get_parent().deixar_anar()
	get_parent().start_sang()
	morir = true
extends KinematicBody2D

var movent = true
var asobre = false
var clicant = false
var clicant_ant = false
var deixat_anar = false
var entra_deixar = false
var es_pot_agafar = false
var morir = false
var velocitat = 4

var valor = 25;
var tipus;
var stage = 0;

var target = Vector2()
var pos_anterior = Vector2()
var scale_d = Vector2(1,1)
var scale_1 = Vector2(2,2)
var scale_2 = Vector2(3,3)
var next_scale = Vector2()
var next_scale_cabezo = Vector2()
var pos_inicial = Vector2()
var pos_calderon = Vector2()

const p_1 = Vector2(0,550)
const p_2 = Vector2(384,0)
const p_3 = Vector2(0,690)
const p_4 = Vector2(896,0)

func _ready():
	var n_aleatori = randi() % 2
	$Cap.frame = n_aleatori
	z_index = -2

func asignar(tipus_n):
	tipus = tipus_n
	if (tipus == "FAT"):
		$Cap.set_texture(load("res://Sprites/Sacrificis/caps.png"))
		$Cos/Sprite.set_texture(load("res://Sprites/Sacrificis/GorditaSpritesCuerpo.png"))
	elif (tipus == "BLOOD"):
		$Cap.set_texture(load("res://Sprites/Sacrificis/caps_musculitos.png"))
		$Cos/Sprite.set_texture(load("res://Sprites/Sacrificis/MusculitosSpritesCuerpo.png"))
	else:
		$Cap.set_texture(load("res://Sprites/Sacrificis/caps_carn.png"))
		$Cos/Sprite.set_texture(load("res://Sprites/Sacrificis/CarneSpritesHomeDonaCuerpo.png"))

func _on_KinematicBody2D_mouse_entered():
	asobre = true
	clicant_ant = false


func _on_KinematicBody2D_mouse_exited():
	if (not clicant):
		asobre = false

func _process(delta):
	if (get_parent().stop and stage != 0):
		movent = false
	else:
		movent = true

func _physics_process(delta):
	#rotation += 20
	pos_anterior = position
	clicant = Input.is_action_pressed("click")
	es_pot_agafar = get_parent().comp_agafar(self)
	next_scale_cabezo = Vector2(0.5,0.5)
	if (!morir):
		if (asobre and !clicant_ant and es_pot_agafar):
			next_scale_cabezo = Vector2(1,1)
			z_index = 0
		else:
			next_scale = scale_d
			next_scale_cabezo = Vector2(0.5,0.5)
			z_index = 0
	
		if (asobre and clicant and es_pot_agafar):
			agafar()
			next_scale_cabezo = Vector2(0.5,0.5)
		elif(asobre and clicant_ant):
			deixat_anar = true
		if (deixat_anar and not entra_deixar):
			deixar_anar()
		elif(entra_deixar and not clicant and deixat_anar):
			eliminar()
		
		scale.y = lerp(scale.y, next_scale.y, 0.2);
		scale.x = lerp(scale.x, next_scale.x, 0.2);
		
		$Cap.scale.y = lerp($Cap.scale.y, next_scale_cabezo.y, 0.2);
		$Cap.scale.x = lerp($Cap.scale.x, next_scale_cabezo.x, 0.2);
		
		if (movent):
			position = guia(position)
			pos_inicial = position
		else:
			pos_inicial = guia(pos_inicial)
	else:
		scale.y = lerp(scale.y, 0, 0.2);
		scale.x = lerp(scale.x, 0, 0.2);
		position.y = lerp(position.y, 736, 0.1);
		position.x = lerp(position.x, 1632, 0.1);
		z_index = 10
		
		if (scale.y < 0.3):
			queue_free()
			#get_parent().stop_sang()

func guia(posicio_actual):
	if (posicio_actual.y < p_1.y and stage == 0):
		posicio_actual.y += velocitat + 5
		z_index = 1
		if posicio_actual.y >= p_1.y:
			stage = 1
	elif (stage == 1):
		z_index = 2
		posicio_actual.x -= velocitat
		if posicio_actual.x <= p_2.x:
			stage = 2
	elif (stage == 2):
		posicio_actual.x -= velocitat
		posicio_actual.y += velocitat
		z_index = 3
		if posicio_actual.y >= p_3.y:
			stage = 3
	elif (stage == 3):
		z_index = 4
		posicio_actual.x += velocitat
		if (posicio_actual.x >= p_4.x):
			stage = 4
	elif (stage == 4):
		get_parent().stop = true;
		stage = 5
	return posicio_actual

func agafar():
	z_index = 50
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
		GlobalVar.blood_rec += valor * 0.5
		GlobalVar.fat_rec += valor * 0.5
		pass
	elif (tipus == "BLOOD"):
		GlobalVar.blood_rec += valor
#		print("BLOOD")
#		print(GlobalVar.blood_rec)
	elif (tipus == "FAT"):
		GlobalVar.fat_rec += valor
#		print("FAT")
#		print(GlobalVar.fat_rec)
	GlobalVar.contador_personas -= 1
	if (stage == 5):
		get_parent().stop = false;
	get_parent().start_sang()
	get_tree().get_root().get_node("Game").screen_shake(5)
	get_parent().deixar_anar()
	morir = true
extends Node2D

var _tipus = "BLOOD";

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func inicialitzar_sprites(tipus):
	_tipus = tipus;
	pass

func actuar_blood():
	yield(get_tree().create_timer(0.3), "timeout");
	$sprite/blood.emitting = true;
	yield(get_tree().create_timer(1), "timeout");
	$sprite/blood.emitting = false;
	sortir();

func actuar_defend():
	yield(get_tree().create_timer(0.3), "timeout");
	yield(get_tree().create_timer(1), "timeout");
	sortir();

func entrar():
	$sprite/animacio.play("Entrar_sala");
	if _tipus == "BLOOD":
		actuar_blood();
	elif _tipus == "DEFEND":
		actuar_defend();


func sortir():
	$sprite/animacio.play("Sortir_sala");

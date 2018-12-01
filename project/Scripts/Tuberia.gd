extends "res://Scripts/Tuberia.gd"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func inicialitzar_sprites(tipus):
	#COLOCAR SPRITE CORRECTAMENT
	pass

func entrar():
	$sprite/animacio.play("Entrar_sala");

func sortir():
	$sprite/animacio.play_backwards("Entrar_sala");
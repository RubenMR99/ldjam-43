extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$T_attack.inicialitzar_sprites("BLOOD");
	$T_defend.inicialitzar_sprites("DEFEND");



func _on_T_attack_pressed():
	$T_attack.entrar();

func _on_T_defend_pressed():
	$T_defend.entrar();

extends Node

var escut = preload("res://Scenes/Escut.tscn");

func _ready():
	$Camera.make_current();
	update_HUD();
	pass

func update_HUD():
	$Camera/HUD/Meat.value = GlobalVar.meat_rec;
	$Camera/HUD/Blood.value = GlobalVar.blood_rec;
	$Camera/HUD/Fat.value = GlobalVar.fat_rec;

func _process(delta):
	GlobalVar.meat_rec += 0.5;
	GlobalVar.blood_rec += 0.5;
	GlobalVar.fat_rec += 0.5;
	update_HUD();
	$field.comproba_buttons();

func _on_factoryButton_pressed():
	$Camera/anim.play("moure_dreta");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play("ves_dreta");
	$field.comproba_buttons();
	GlobalVar.pos = "field";

func _on_fieldButton_pressed():
	$Camera/anim.play("moure_esquerra");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play_backwards("ves_dreta");
	$field.comproba_buttons();
	GlobalVar.pos = "factory";

func _activa_escut():
	print("l");
	var s = escut.instance();
	s.position.x = 0 + GlobalVar.escut * 65;
	GlobalVar.escut += 1;
	s.position.y = 100;
	$Camera/HUD/Cont.add_child(s);

func _run_out_shield():
	print("yay")
	GlobalVar.escut -= 1;
	for node in $Camera/HUD/Cont.get_children():
		node.position.x -= 65;

func _on_enemy_attacking():
	print("x");

func _on_incoming_damage():
	print("o");
	if GlobalVar.pos == "factory":
		$field/vigila/anim.play("apareixer_vigila");

func _on_enemy_killed():
	print("k");
	$field/Enemy.inicialitzar_nou_enemic();
extends Node

func _ready():
	$Camera.make_current();
	update_HUD()
	pass

func update_HUD():
	$Camera/HUD/Meat.value = GlobalVar.meat_rec;
	$Camera/HUD/Blood.value = GlobalVar.blood_rec;
	$Camera/HUD/Fat.value = GlobalVar.fat_rec;

func _on_factoryButton_pressed():
	$Camera/anim.play("moure_dreta");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play("ves_dreta");
	$field.comproba_buttons();

func _on_fieldButton_pressed():
	$Camera/anim.play("moure_esquerra");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play_backwards("ves_dreta");
	$field.comproba_buttons();

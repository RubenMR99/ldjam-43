extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$T_attack.inicialitzar_sprites("BLOOD");
	$T_defend.inicialitzar_sprites("DEFEND");
	

func comproba_buttons():
	if(GlobalVar.blood_rec < 100):
		$Buttons/T_attack.disabled = true;
	else:
		$Buttons/T_attack.disabled = false;
	
	if(GlobalVar.fat_rec >= 100):
		$Buttons/T_defend.disabled = true;
	else:
		$Buttons/T_defend.disabled = false;


func _on_T_attack_pressed():
	$T_attack.entrar();
	GlobalVar.blood_rec = 0;
	get_parent().update_HUD();
	comproba_buttons();
	$Enemy.atacar(75);

func _on_T_defend_pressed():
	$T_defend.entrar();
	GlobalVar.fat_rec = 0;
	get_parent().update_HUD();
	comproba_buttons();

extends Node2D

signal shield;

func _ready():
	$T_attack.inicialitzar_sprites("BLOOD");
	$T_defend.inicialitzar_sprites("DEFEND");
	self.connect("shield", get_parent(), "_activa_escut");

func comproba_buttons():
	if(GlobalVar.blood_rec < 100):
		$Buttons/T_attack.disabled = true;
	else:
		$Buttons/T_attack.disabled = false;
	
	if(GlobalVar.fat_rec >= 100 and GlobalVar.escut < 3):
		$Buttons/T_defend.disabled = false;
	else:
		$Buttons/T_defend.disabled = true;

func _on_T_attack_pressed():
	$T_attack.entrar();
	GlobalVar.blood_rec = 0;
	get_parent().update_HUD();
	comproba_buttons();
	$Enemy.atacar(75);

func _on_T_defend_pressed():
	$T_defend.entrar();
	GlobalVar.fat_rec = 0;
	emit_signal("shield");
	get_parent().update_HUD();
	comproba_buttons();

func _on_incoming_attack():
	if GlobalVar.pos == "factory":
		$vigila/anim.play("apareixer_vigila");
		get_parent()._on_factoryButton_pressed();

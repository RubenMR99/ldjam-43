extends Node

var escut = preload("res://Scenes/Escut.tscn");

var shake_amount = 0;

func _ready():
	$Camera.make_current();
	$Camera/GameOver.visible = false;
	$Player/Sprite.flip_h = true;
	update_HUD();

func update_HUD():
	$Camera/HUD/Blood.value = GlobalVar.blood_rec;
	$Camera/HUD/Fat.value = GlobalVar.fat_rec;
	$Camera/HUD.dibuixar_vida();
	$field/pompa.colocar(GlobalVar.escut);

func _process(delta):
	print(GlobalVar.vida)
	if Input.is_action_pressed("ui_up"):
		screen_shake(0.5);
	
	$field.comproba_buttons();
	if shake_amount >= 0:
		$Camera.set_offset(Vector2( 
			rand_range(-1.0, 1.0) * shake_amount, 
			rand_range(-1.0, 1.0) * shake_amount 
		))
		shake_amount -= 0.1;
	update_HUD();
	
	if GlobalVar.vida <= 0:
		$Camera/GameOver.visible = true;

func _on_factoryButton_pressed():
	$Camera/anim.play("moure_dreta");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play("ves_dreta");
	$field.comproba_buttons();
	GlobalVar.pos = "field";
	$Player/Sprite.flip_h = false;

func _on_fieldButton_pressed():
	$Camera/anim.play("moure_esquerra");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play_backwards("ves_dreta");
	$field.comproba_buttons();
	GlobalVar.pos = "factory";
	$Player/Sprite.flip_h = true;

func _activa_escut():
	var s = escut.instance();
	s.position.x = 0 + GlobalVar.escut * 65;
	GlobalVar.escut += 1;
	s.position.y = 100;
	$Camera/HUD/Cont.add_child(s);
	$field/pompa.colocar(GlobalVar.escut);

func _run_out_shield():
	GlobalVar.escut -= 1;
	for node in $Camera/HUD/Cont.get_children():
		node.position.x -= 65;
		if(node.position.x < -10):
			node.queue_free();
	$field/pompa.colocar(GlobalVar.escut);

func _on_enemy_attacking(damage):
	var aux = GlobalVar.escut - damage;
	
	if aux <= 0:
		for node in $Camera/HUD/Cont.get_children():
			node.queue_free();
		GlobalVar.vida += aux;
		for i in range(GlobalVar.escut):
			_run_out_shield();
	else:
		for i in range(damage):
			_run_out_shield();
	update_HUD();

func _on_enemy_killed():
	pass

func screen_shake(valor):
	shake_amount += valor;
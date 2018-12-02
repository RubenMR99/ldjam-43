 extends Node2D

signal damage;
signal damage_incoming;
signal killed;

var j = preload("res://Sprites/Enemy/Jutge.png");
var p = preload("res://Sprites/Enemy/Poli.png");
var m = preload("res://Sprites/Enemy/Mono.png");

var x1 = preload("res://Sprites/Enemy/DAÑO CORA x1.png");
var x2 = preload("res://Sprites/Enemy/DAÑO CORA x2.png");
var x3 = preload("res://Sprites/Enemy/DAÑO CORA X3.png");

var _velocity = 0;
var _tipus;
var _vida = 0;
var _vida_inicial = 0;
var dany_seguent = 0;

var one_time = false;

func random_type():
	var aux = randi()%3;
	match aux:
		0:
			$Sprite.set_texture(j);
			_tipus = "jutge";
		1:
			$Sprite.set_texture(p);
			_tipus = "poli";
		2:  
			$Sprite.set_texture(m);
			_tipus = "mono";
			

func _ready():
	randomize();
	self.connect("damage", get_parent().get_parent(), "_on_enemy_attacking");
	self.connect("damage_incoming", get_parent(), "_on_incoming_attack");
	self.connect("killed", get_parent().get_parent(), "_on_enemy_killed");
	inicialitzar_nou_enemic();

func _process(delta):
	$Carrega/ProgressBar.value += _velocity;
	if($Carrega/ProgressBar.value >= 60 and not one_time):
		emit_signal("damage_incoming");
		print("damage_incoming");
		one_time = true;
	elif($Carrega/ProgressBar.value >= 100):
		$Carrega/ProgressBar.value = 0;
		_atacar();

func mostrar_seguent():
	match dany_seguent:
		1: $Next_damage.set_texture(x1);
		2: $Next_damage.set_texture(x2);
		3: $Next_damage.set_texture(x3);

func _atacar():
	set_process(false);
	match _tipus:
		"mono":
			$Sprite/animacio.play("attack_mono");
			yield(get_tree().create_timer(0.3), "timeout");
			$Coin.restart();
			yield(get_tree().create_timer(0.7), "timeout");
			$Sprite/animacio.play_backwards("attack_mono");
		"jutge":
			$Sprite/animacio.play("attack_jutge");
			yield(get_tree().create_timer(1), "timeout");
		"poli":
			$Sprite/animacio.play("attack_poli");
			yield(get_tree().create_timer(1,5), "timeout");
	set_process(true);
	one_time = false;
	emit_signal("damage", dany_seguent);
	dany_seguent = randi()%3+1;
	mostrar_seguent();

func inicialitzar_nou_enemic():
	$Carrega/ProgressBar.value = 0;
	_vida_inicial += 100;
	_vida = _vida_inicial;
	_velocity += 0.02;
	random_type();
	match _tipus:
		"jutge": 
			$VidaEnemic.position.y = -262;
			$Carrega.position.y = -262+75;
			$Next_damage.position.y = -262-75;
		"poli": 
			$VidaEnemic.position.y = -450;
			$Carrega.position.y = -450+75;
			$Next_damage.position.y = -450-75;
		"mono": 
			$VidaEnemic.position.y = -450;
			$Carrega.position.y = -450+75;
			$Next_damage.position.y = -450-75;
	
	$VidaEnemic.dibuixar(_vida);

func atacar(damage):
	_vida -= damage;
	$Sprite/animacio.play("hurt")
	if _vida <= 0:
		emit_signal("killed");
		set_process(false);
		yield(get_tree().create_timer(0.3), "timeout");
		$Mort.restart();
		$Sprite.visible = false;
		$Carrega.visible = false;
		$VidaEnemic.visible = false;
		$Next_damage.visible = false;
		inicialitzar_nou_enemic();
		yield(get_tree().create_timer(1.4), "timeout");
		$Sprite.visible = true;
		$Carrega.visible = true;
		$VidaEnemic.visible = true;
		$Next_damage.visible = true;
		set_process(true);
	else:
		$VidaEnemic.dibuixar(_vida);
	
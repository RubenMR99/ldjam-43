extends Node2D

signal damage;
signal damage_incoming;
signal killed;

var j = preload("res://Sprites/Enemy/Jutge.png");
var p = preload("res://Sprites/Enemy/Poli.png");
var m = preload("res://Sprites/Enemy/Mono.png");


var _velocity = 0;
var _tipus;
var _vida = 0;
var _vida_inicial = 0;

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
	self.connect("damage_incoming", get_parent().get_parent(), "_on_incoming_attack");
	self.connect("killed", get_parent().get_parent(), "_on_enemy_killed");
	inicialitzar_nou_enemic();
	pass

func _process(delta):
	$Carrega/ProgressBar.value += _velocity;
	if($Carrega/ProgressBar.value == 90):
		emit_signal("damage_incoming");
	elif($Carrega/ProgressBar.value >= 100):
		$Carrega/ProgressBar.value = 0;
		emit_signal("damage", 1);

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
		"poli": 
			$VidaEnemic.position.y = -450;
			$Carrega.position.y = -450+75;
		"mono": 
			$VidaEnemic.position.y = -450;
			$Carrega.position.y = -450+75;
	
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
		inicialitzar_nou_enemic();
		yield(get_tree().create_timer(1.4), "timeout");
		$Sprite.visible = true;
		$Carrega.visible = true;
		$VidaEnemic.visible = true;
		set_process(true);
	else:
		$VidaEnemic.dibuixar(_vida);
	
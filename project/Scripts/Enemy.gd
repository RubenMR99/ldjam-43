extends Node2D

signal damage;
signal damage_incoming;
signal killed;

var _velocity = 0.01;
var _tipus = "jutge";
var _vida = 100;
var _vida_inicial = 100;

func _ready():
	self.connect("damage", get_parent().get_parent(), "_on_enemy_attacking");
	self.connect("damage_incoming", get_parent().get_parent(), "_on_incoming_attack");
	self.connect("killed", get_parent().get_parent(), "_on_enemy_killed");
	pass

func _process(delta):
	$Carrega/ProgressBar.value += _velocity;
	if($Carrega/ProgressBar.value == 75):
		emit_signal("damage_incoming");
	elif($Carrega/ProgressBar.value >= 100):
		$Carrega/ProgressBar.value = 0;
		emit_signal("damage");

func inicialitzar_nou_enemic():
	_tipus = "jutge";
	_vida_inicial += 100;
	_vida = _vida_inicial;
	_velocity += 0.02;
	$VidaEnemic.dibuixar(_vida);

func atacar(damage):
	_vida -= damage;
	if _vida <= 0:
		emit_signal("killed");
	else:
		$VidaEnemic.dibuixar(_vida);
	
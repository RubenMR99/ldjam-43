extends Node2D

var health = preload("res://icon.png"); 

func _ready():
	dibuixar_vida(1);

func dibuixar_vida(vida):
	for i in range(vida):
		var s = Sprite.new();
		s.set_texture(health);

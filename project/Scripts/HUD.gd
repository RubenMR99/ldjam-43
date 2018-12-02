extends Node2D

var health = preload("res://Sprites/player/CORAZON.png"); 

func _ready():
	dibuixar_vida();

func dibuixar_vida():
	for node in $ContLife.get_children():
		node.queue_free();
	
	for i in range(GlobalVar.vida):
		var s = Sprite.new();
		s.set_texture(health);
		$ContLife.add_child(s);
		s.scale.x = 0.05;
		s.scale.y = 0.05;
		s.position.y = 50;
		s.position.x = 0 + i*65;

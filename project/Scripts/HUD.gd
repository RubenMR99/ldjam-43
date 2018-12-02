extends Node2D

var health = preload("res://icon.png"); 

func _ready():
	dibuixar_vida(3);

func dibuixar_vida(vida):
	for node in $ContLife.get_children():
		node.queue_free();
	
	for i in range(vida):
		var s = Sprite.new();
		s.set_texture(health);
		$ContLife.add_child(s);
		s.position.y = 50;
		s.position.x = 0 + i*65;

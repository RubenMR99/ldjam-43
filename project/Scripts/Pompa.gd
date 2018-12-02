extends Node2D

var _num = 0;
var sprite_pompa = preload("res://Sprites/Field/escutimg.png");

func _ready():
	update_escuts();
	pass

func colocar(num):
	_num = num;
	update_escuts();

func update_escuts():
	for node in get_children():
		node.queue_free();
	for i in range(_num):
			var s = Sprite.new();
			s.set_texture(sprite_pompa);
			s.centered = true;
			add_child(s);
			s.modulate.a = 0.33
			s.scale.x = 0.3*(i+1)*1.5;
			s.scale.y = 0.3*(i+1)*1.5;


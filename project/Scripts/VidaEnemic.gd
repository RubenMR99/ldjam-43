extends Node2D
var _vida = 100;

var r = preload("res://Sprites/Barres/BARRA VIDA ROJA.png");
var bk = preload("res://Sprites/Barres/BARRA VIDA NEGRA.png");


func _ready():
	update_barres();

func update_barres():
	var aux = int(_vida)/100+1;
	if int(_vida)%100 == 0:
		aux -= 1;
		$Primera/one.value = _vida/aux;
	else:
		$Primera/one.value = int(_vida%100);
	
	if _vida < 100:
		$image_interior.set_texture(bk);
	else:
		$image_interior.set_texture(r);

func dibuixar(vida):
	_vida = vida;
	update_barres();
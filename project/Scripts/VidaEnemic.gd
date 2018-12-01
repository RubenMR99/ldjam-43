extends Node2D
var _vida = 100;

func _ready():
	update_barres();

func update_barres():
	var aux = int(_vida)/100+1;
	if int(_vida)%100 == 0:
		aux -= 1;
		$Primera/one.value = _vida/aux;
	else:
		$Primera/one.value = int(_vida%100);
	
	$Cops.text = String(aux);
	if _vida < 100:
		$image_interior.modulate = (Color(0,0,0));
	else:
		$image_interior.modulate = (Color(255,0,0));

func dibuixar(vida):
	_vida = vida;
	update_barres();
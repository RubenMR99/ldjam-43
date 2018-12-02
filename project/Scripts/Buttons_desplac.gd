extends Area2D

var posicio = "entrats";
var mostrantse = false;

func _ready():
	$anim.play("amagar");

func _on_Buttons_mouse_entered():
	if not mostrantse:
		$anim.play_backwards("amagar");
		mostrantse = true;

func _on_Buttons_mouse_exited():
	if mostrantse:
		$anim.play("amagar");
		mostrantse = false;


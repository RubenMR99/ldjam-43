extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Camera.make_current();
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_factoryButton_pressed():
	$Camera/anim.play("moure_dreta");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play("ves_dreta");


func _on_fieldButton_pressed():
	$Camera/anim.play("moure_esquerra");
	yield(get_tree().create_timer(0.5), "timeout");
	$Player/Sprite/animacio.play_backwards("ves_dreta");

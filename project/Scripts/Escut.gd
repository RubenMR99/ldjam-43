extends Node2D

var velocity = 0.1;
signal no_time;

func _ready():
	self.connect("no_time", get_tree().get_root().get_node("Game"), "_run_out_shield");
	$bar.value = 100;

func _process(delta):
	$bar.value -= velocity;
	if $bar.value <= 0:
		emit_signal("no_time");
		queue_free();

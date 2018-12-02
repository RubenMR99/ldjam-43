extends Node2D

# class member variables go here, for example:
# var a = 2
var stop = false
var agafats = 0
var agafat_obj

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().reload_current_scene()
	pass

func _on_Caldero_body_entered(body):
	if (body.get_class() == "KinematicBody2D"):
		body.entrada_caldero();


func _on_Caldero_body_exited(body):
	if (body.get_class() == "KinematicBody2D"):
		body.sortida_caldero();
	pass

func deixar_anar():
	agafats = 0
	agafat_obj = 0

func comp_agafar(body):
	if (agafats < 1):
		return true
	elif (body == agafat_obj):
		return true
	else:
		return false

func agafar(body):
	if (agafats < 1):
		body.es_pot_agafar = true
		agafat_obj = body
		agafats += 1
	else:
		if (body == agafat_obj):
			body.es_pot_agafar = true
		else:
			body.es_pot_agafar = false
			
func stop_sang():
	$Sangre.emitting = false
	pass

func start_sang():
	$Sangre.emitting = true
	pass
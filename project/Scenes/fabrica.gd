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
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func _on_Caldero_body_entered(body):
	body.entrada_caldero();


func _on_Caldero_body_exited(body):
	body.sortida_caldero();

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
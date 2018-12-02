extends Area2D

const PERSONA = preload("res://Scenes/persona.tscn");
var temps = 0
const temps_entre_generar = 150

func _physics_process(delta):
	temps = temps + 1
	if (temps >= temps_entre_generar and GlobalVar.contador_personas < GlobalVar.MAX_PERSONAS):
		temps = 0
		var pers_nova = PERSONA.instance()
		GlobalVar.contador_personas += 1
		get_parent().add_child(pers_nova)
		pers_nova.position = $Position2D.global_position
		
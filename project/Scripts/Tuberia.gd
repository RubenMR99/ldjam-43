extends Area2D

const PERSONA = preload("res://Scenes/persona.tscn");
var tipus = "MEAT"
var temps = 0
const temps_entre_generar = 200

func _ready():
	var nom_propi = str(self.name)
	if (nom_propi == "Tuberia_M"):
		tipus = "MEAT"
	elif(nom_propi == "Tuberia_B"):
		tipus = "BLOOD"
	else:
		tipus = "FAT"

func _physics_process(delta):
	temps = temps + 1
	if (temps >= temps_entre_generar and GlobalVar.contador_personas < GlobalVar.MAX_PERSONAS):
		temps = 0
		var pers_nova = PERSONA.instance()
		pers_nova.asignar(tipus)
		GlobalVar.contador_personas += 1
		get_parent().add_child(pers_nova)
		pers_nova.position = $Position2D.global_position
		
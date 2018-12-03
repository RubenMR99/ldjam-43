extends Area2D

const PERSONA = preload("res://Scenes/persona.tscn");
var tipus = "MEAT"
var temps = 0
const temps_entre_generar = 200

func _ready():
	z_index = 20
	var nom_propi = str(self.name)
	if (nom_propi == "Tuberia_M"):
		tipus = "MEAT"
	elif(nom_propi == "Tuberia_B"):
		tipus = "BLOOD"
	else:
		tipus = "FAT"

func _physics_process(delta):
	var num_rand = randi() % 1000
	print(num_rand)
	if (num_rand < 3 and GlobalVar.contador_personas < GlobalVar.MAX_PERSONAS):
		var pers_nova = PERSONA.instance()
		pers_nova.asignar(tipus)
		GlobalVar.contador_personas += 1
		get_parent().add_child(pers_nova)
		pers_nova.position = $Position2D.global_position
		
extends Node

const MAX_PERSONAS = 5;
var contador_personas = 0;

var vida = 3;
var escut = 0;
var meat_rec;
var fat_rec;
var blood_rec;
var pos;

func _ready():
	meat_rec = 0;
	fat_rec = 100;
	blood_rec = 100;
	pos = "factory";
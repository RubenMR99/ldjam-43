extends Node

const MAX_PERSONAS = 5;
var contador_personas = 0;

var vida = 3;
var escut = 0;
var meat_rec =0;
var fat_rec;
var blood_rec;
var pos;

func _ready():
	fat_rec = 0;
	blood_rec = 0;
	pos = "factory";
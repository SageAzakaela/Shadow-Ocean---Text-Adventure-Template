extends Node

var ap : int = 100
var health : int  = 100
var credits : int = 300
var current_location : String = "Home"
var last_location : String = "Null"
var hunger : int = 0
var thirst : int = 0
var sanity : int = 100
var skills : Array = []
var objectives: Array = []
var inventory: Array = []
var current_npc: String = ""

func _process(_delta):
	if ap <= 0:
		ap = 0

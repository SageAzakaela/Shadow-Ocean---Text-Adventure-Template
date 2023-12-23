extends Node

var note_array : Array = [] 

func _ready():
	for child in get_children():
		note_array.append(child.note_text)

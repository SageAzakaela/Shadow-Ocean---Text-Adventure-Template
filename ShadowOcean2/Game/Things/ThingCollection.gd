extends Control


@export var things : Array[String] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for thing in things:
		var thing_to_instance = load(thing).instantiate()
		get_parent().add_child(thing_to_instance)
		queue_free()

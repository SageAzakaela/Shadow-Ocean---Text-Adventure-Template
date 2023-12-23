extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_parent().item_container:
		if child.item_type == "shell":
			action_container

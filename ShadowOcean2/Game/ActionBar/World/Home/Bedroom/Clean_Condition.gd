extends Node


func _process(_delta):
	if Player.inventory.has("silver key"):
		get_parent().queue_free()
		

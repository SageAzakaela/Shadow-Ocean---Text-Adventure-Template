extends Node



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Player.current_npc != "":
		get_parent().disabled = true
	else:
		get_parent().disabled = false
		
	if Player.current_location == "Home":
		get_parent().visible = false
	elif Player.current_location == "Bedroom":
		get_parent().visible = false
	elif Player.current_location == "Living Room":
		get_parent().visible = false
	elif Player.current_location == "Alchemy Lab":
		get_parent().visible = false
	elif Player.current_location == "Control Room":
		get_parent().visible = false
	elif Player.current_location == "Study":
		get_parent().visible = false
	else:
		get_parent().visible = true
	
	

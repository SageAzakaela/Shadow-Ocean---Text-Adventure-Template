extends TextureRect


@export var npc : String = ""



func _process(_delta):
	if Player.current_npc == npc:
		self.visible = true
	else:
		self.visible = false
		

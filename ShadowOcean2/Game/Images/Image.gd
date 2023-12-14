extends TextureRect

@onready var ambience = $Ambience

@export var location : String = ""

func _ready():
	ambience.volume_db = -80


func _process(_delta):
	if Player.current_location == location:
		self.visible = true
	else:
		self.visible = false
		
	if visible == true:
		ambience.volume_db = -8
	else:
		ambience.volume_db = -80
		

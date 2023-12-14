extends Label

@export var skill : String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	Player.skills.append(skill)
	text = skill

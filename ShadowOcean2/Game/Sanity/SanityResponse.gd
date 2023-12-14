extends Label


@export_multiline var message: String = ""

func _ready():
	text = message

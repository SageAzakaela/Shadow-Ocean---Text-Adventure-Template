extends ColorRect

@export var sky_color: int = 0
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if GlobalTime.currentColor == sky_color:
		visible = true
	else:
		visible = false

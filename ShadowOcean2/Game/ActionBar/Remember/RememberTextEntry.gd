extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


func _on_action_button_pressed():
	grab_focus()
	
func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		grab_focus()

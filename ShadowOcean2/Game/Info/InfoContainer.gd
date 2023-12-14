extends VBoxContainer

@onready var time = $Time
@onready var location = $Location
@onready var action_points = $ActionPoints
@onready var health = $Health
@onready var sanity = $Sanity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time.text = "Who cares?"
	location.text = Player.current_location
	action_points.text = str(Player.ap)
	health.text = str(Player.health)
	sanity.text = str(Player.sanity)

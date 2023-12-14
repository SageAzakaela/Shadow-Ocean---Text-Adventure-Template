extends Button

@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@export var objective : String = ""
@export_multiline var objective_description : String = ""
@onready var interact_noise = $"../../../../InteractNoise"

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.objectives.append(objective)
	text = objective


func _on_pressed():
	interact_noise.play()
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = objective_description

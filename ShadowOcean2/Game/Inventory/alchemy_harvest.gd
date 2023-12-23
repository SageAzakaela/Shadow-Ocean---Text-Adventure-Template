extends Button


@onready var history_container = $"../../../../../HistoryPanel/ScrollContainer/HistoryContainer"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Player.current_location != "Alchemy Lab":
		queue_free()


func _on_pressed():
	var item = get_parent()
	var components_string = "You manage to extract and harvest the following Ephemeral Currents:\n\n"
	for component in item.base_components:
		components_string += (component + "\n")
		Home.AlchemyComponents.append(component)
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = components_string
	item.queue_free()
	

extends VBoxContainer

@onready var timer = $"../Timer"
@export_multiline var sanity_messages: Array[String] = []

func ready():
	randomize()

func _on_timer_timeout():
	if sanity_messages.size() > 0:
		# Pick a random message index
		var random_index = randi() % sanity_messages.size()

		# Get the random message
		var random_message = sanity_messages[random_index]

		# Instance the SanityResponse scene
		var message_instance = preload("res://Game/Sanity/SanityResponse.tscn").instantiate()

		# Set the message in the instance
		message_instance.message = random_message

		# Add the instance to the parent node
		add_child(message_instance)
	else:
		print("No sanity messages available.")


func _on_child_entered_tree(node):
	for child in get_children():
		if child != node:
			child.queue_free()

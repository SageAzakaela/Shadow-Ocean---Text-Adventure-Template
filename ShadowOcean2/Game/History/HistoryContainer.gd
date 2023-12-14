extends VBoxContainer


func _on_child_entered_tree(node):
	for child in get_children():
		if child != node:
			child.queue_free()

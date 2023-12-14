extends VBoxContainer

var uniqueSkills := {}

func _process(_delta):
	for skill in get_children():
		# Assuming each skill has a unique identifier, like a name or ID
		var skillKey = skill.skill

		if uniqueSkills.has(skillKey):
			# Duplicate skill found, remove it
			skill.queue_free()
		else:
			# Add the skill to the dictionary to keep track of it
			uniqueSkills[skillKey] = skill

extends Node

@onready var remember_text_entry = $"../RememberTextEntry"
@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var interact_noise = $"../../../../InteractNoise"
@onready var interact_noise_2 = $"../../../../InteractNoise2"
@onready var objective_container = $"../../../../ObjectivePanel/ScrollContainer/ObjectiveContainer"
@onready var skill_container = $"../../../../SkillPanel/SkillScroll/SkillContainer"


var current_memory_index : int = -1

func _on_remember_text_entry_text_submitted(new_text):
	interact_noise.play()
	check_memory(new_text)

func _on_remember_text_entry_text_changed(new_text):
	interact_noise_2.play()
	highlight_matching_memory(new_text)

func check_memory(input_text):
	for memory in get_children():
		if input_text.to_lower() == memory.memory_key.to_lower():
			process_correct_memory(memory)
			return
	process_incorrect_memory()

func process_correct_memory(memory):
	if memory.memory_content.size() > 0:
		current_memory_index = (current_memory_index + 1) % memory.memory_content.size()
		if memory.unlock_objective == true:
			memory.unlock_objective = false
			var objective_to_add = load(memory.objective_path).instantiate()
			objective_container.add_child(objective_to_add)
		if memory.unlock_skill == true:
			memory.unlock_skill = false
			var skill_to_add = preload("res://Game/Skills/skill.tscn").instantiate()
			skill_container.add_child(skill_to_add)
			skill_to_add.text = memory.skill_name
		var memory_text = memory.memory_content[current_memory_index]
		var response_label = preload("res://Game/History/respnse.tscn").instantiate()
		history_container.add_child(response_label)
		response_label.text = memory_text
	else:
		print("Memory has no content.")

func process_incorrect_memory():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = "You don't recall anything about that."

func highlight_matching_memory(input_text):
	for memory in get_children():
		if input_text.to_lower() == memory.memory_key.to_lower():
			remember_text_entry.self_modulate = Color(0, 1, 1)  # Change text color to blue
			return
	remember_text_entry.self_modulate = Color(1, 1, 1)  # Reset text color to white

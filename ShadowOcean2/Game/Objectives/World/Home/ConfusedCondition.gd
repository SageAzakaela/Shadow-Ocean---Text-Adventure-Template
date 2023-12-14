extends Node

@onready var skill_container = $"../../../../../SkillPanel/SkillScroll/SkillContainer"


var criteria_met : int = 0
var completed_objective = false

func _on_remember_text_entry_text_submitted(new_text):
	if new_text == "you".to_lower():
		criteria_met += 1
	if new_text == "why you're here".to_lower():
		criteria_met += 1
	if new_text == "your name".to_lower():
		criteria_met += 1
	if new_text == "lighthouse".to_lower():
		criteria_met += 1

	
	if criteria_met == 15 and completed_objective == false:
		completed_objective = true
		get_parent().objective = "Check Control Room"
		get_parent().text = get_parent().objective
		get_parent().objective_description = "Ah! You've remembered that you're the Lighthouse Mechanic!  You remember that it's your duty to upkeep it, lest there be tragedies out on Gate beyond that which is the Umbra.  You must maintain the beacon."
		
		var lighthouse_mechanic = preload("res://Game/Skills/skill.tscn").instantiate()
		skill_container.add_child(lighthouse_mechanic)
		lighthouse_mechanic.skill = "Lighthouse Mechanic"
		lighthouse_mechanic.text = lighthouse_mechanic.skill
		Player.objectives.erase("confused")
		Player.objectives.append("check_control_room")

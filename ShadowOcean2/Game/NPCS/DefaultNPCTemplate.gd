extends "res://Game/NPCS/NPC.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "NPC Name"
	dialogue_tree = {
		"start": {
			"text": "Introduction text.",
			"options": {
				"1": {
					"option_name": "Option 1",
					"response_text": "Response to Option 1.",
					"mechanics": {
						"remove_npc": false,
						"add_item": "item_name",
						"remove_item": "item_name",
						"change_location": "location_path",
						"add_objective": "objective_path",
						"health_effect": 0,
						"santiy_effect": 0,
						"ap_effect": 0,
						"time_effect": 0,
					},
					"next_node": "next_node_name",
				},
				"2": {
					"option_name": "Option 2",
					"response_text": "Response to Option 2.",
					"next_node": "next_node_name",
				},
			}
		},
		"next_node_name": {
			"text": "Text for the next node.",
			"options": {
				"1": {
					"option_name": "Option 1",
					"response_text": "Response to Option 1.",
					"next_node": "next_node_name",
				},
				"2": {
					"option_name": "Option 2",
					"response_text": "Response to Option 2.",
					"next_node": null,  # End the conversation
				},
			}
		},
		# Add more nodes as needed
	}

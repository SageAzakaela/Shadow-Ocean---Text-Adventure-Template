extends "res://Game/NPCS/NPC.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Visitor"
	NPC_name = "Visitor"
	dialogue_tree = {
		"start": {
			"text": "Hello, just stopping by to deliver some supplies; We haven't seen you at the village in a few days now, and Kar asked me to check on you. How you holding up?",
			"options": {
				"1": {
					"option_name": "Ask about Village",
					"response_text": "Well, it's not the most exciting it's ever been, but I for one like the quiet. Folks around the Tavern are buzzing about the new Pilots in town; maybe you oughta go meet 'em.",
					"next_node": "village_response",
				},
				"2": {
					"option_name": "Complain of Confusion",
					"response_text": "Nothing new there. You have Umbra Sickness, remember? Comes with the territory in your line of work. Come to the tavern when you get the chance and take a break; might help.",
					"next_node": "confusion_response",
				},
				"3": {
					"option_name": "Act Normal",
					"response_text": "Well, glad to hear you're surviving out here. If there's anything you need, come and see me at the Tavern in town, okay?",
					"next_node": null,  # End the conversation
					"mechanics": {
						"add_objective": "res://Game/Objectives/World/Home/Visitor.tscn",
						"objective_text": "Go to Tavern",
						"objective_description": "The visitor who came to the lighthouse earlier wants to meet at the Tavern in the village.",
						"add_item": [
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
						],
					}
				},
				"4": {
					"option_name": "Ask about supplies",
					"response_text": "Usual stuff, alchemical supplies, fuel for the Lighthouse, some tools... And some reading material. There's some interesting new Journer Pilots I'm sure that have some stuff they'd be willing to trade. You oughta come down to the Tavern and meet 'em before they decide to bail.",
					"next_node": "village_response",  # Reuse the village_response node
				},
				"5": {
					"option_name": "Ask about Kar",
					"response_text": "Cantankerous as ever. Health isn't as good these days. I worry about him, and he worries about you, so here I am.",
					"next_node": "village_response",  # Reuse the village_response node
				},
			}
		},
		"confusion_response": {
			"text": "Text for Confusion Response goes here.",
			"options": {
				"1": {
					"option_name": "Ask About Umbra Sickness",
					"response_text": "Feels like every time I run into you like this it's the same conversation. It'll get better, you just need some rest. But I can see in your eyes that I'm not getting through, so... Umbra Sickness happens to some people who are sensitive to it. It's a tale as old as time. People used to stare into the Umbra and induce visions on purpose; these people were considered sages and wise not so long ago -- but ever since the Syndicate began cracking down on it as an Illness that needed curing, it's just become apparent that the way people think isn't the same as it used to be. They see people like you and they think you're dangerous. And I know you're not. Listen, Keeper. Come to the Tavern when you're ready, and I will try my best to snap you out of this okay? Just think about it. I'll be there. I've got to go now.",
					"next_node": null,
					"mechanics": {
						"add_objective": "res://Game/Objectives/World/Home/Visitor.tscn",
						"objective_text": "Go to Tavern",
						"objective_description": "The visitor who came to the lighthouse earlier wants to meet at the Tavern in the village.",
						"add_item": [
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
						],
					}
				},
				"2": {
					"option_name": "Deny Umbra Sickness",
					"response_text": "Well, I'm not here to argue; I'm here to help, remember that. Have you looked in a mirror lately? Your pupils are so wide anyone could see that you're going through the thick of it. Have you lost your lenses? I can get you a replacement pair later if you need. You need to cut back on your visual Umbra Exposure.",
					"next_node": null,
				},
				"3": {
					"option_name": "Agree to meet them later",
					"response_text": "The visitor smiles. Glad to hear it, you won't regret it. I'll see you again, then. Farewell Keeper.",
					"next_node": null,  # End the conversation
					"mechanics": {
						"add_objective": "res://Game/Objectives/World/Home/Visitor.tscn",
						"objective_text": "Go to Tavern",
						"objective_description": "The visitor who came to the lighthouse earlier wants to meet at the Tavern in the village.",
						"add_item": [
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
						],
					}
				},
				"4": {
					"option_name": "Say Nothing",
					"response_text": "You elect to say nothing. The visitor nods to you then says, Well, I won't keep you. But when you're done here, you should come meet us at the Tavern in town. I've got some people who are interested in meeting you.",
					"next_node": "village_response",  # Reuse the village_response node
				},
			}
		},
		"ask_what_they_mean": {
			"text": "You've been neglecting to wear protective gear in your work, and now your brain is all scrambled as a result. This stuff changes your brain; it's dangerous! I know that not even the best lenses can circumvent it, and not everyone needs it, but you need to take better care of yourself, okay? The whole village is counting on this lighthouse to continue running, and you're the only one who can do it. I've said enough. When you're ready, I'd like for you to meet me back at the Tavern in town, okay?",
			"options": {},
			"next_node": null,  # End the conversation
					"mechanics": {
						"add_objective": "res://Game/Objectives/World/Home/Visitor.tscn",
						"objective_text": "Go to Tavern",
						"objective_description": "The visitor who came to the lighthouse earlier wants to meet at the Tavern in the village.",
						"add_item": [
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/Fuel.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
							"res://Game/Inventory/World/Home/Visitor/EnergyBar.tscn",
						],
					}
		},
		"village_response": {
			"text": "Well, it's not the most exciting it's ever been, but I for one like the quiet. Folks around the Tavern are buzzing about the new Pilots in town; maybe you oughta go meet 'em.",
			"options": {
				"1": {
					"option_name": "Return to Greeting",
					"response_text": "Anything else you wanted to know?/",
					"next_node": "start",
				},
				"2": {
					"option_name": "Ask about supplies",
					"response_text": "Usual stuff, alchemical supplies, fuel for the Lighthouse, some tools... And some reading material. There's some interesting new Journer Pilots I'm sure that have some stuff they'd be willing to trade. You oughta come down to the Tavern and meet 'em before they decide to bail.",
					"next_node": "village_response",  # Reuse the village_response node
				},
				"3": {
					"option_name": "Ask about Kar",
					"response_text": "Cantankerous as ever. Health isn't as good these days. I worry about him, and he worries about you, so here I am.",
					"next_node": "village_response",  # Reuse the village_response node
				},
			}
		},
	}

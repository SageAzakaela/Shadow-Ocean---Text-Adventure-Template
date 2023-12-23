extends Button

@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var navigation_container = $"../../../../NavigationPanel/ScrollContainer/NavigationContainer"
@onready var npc_container = $".."
@onready var skill_container = $"../../../../SkillPanel/SkillScroll/SkillContainer"
@onready var objective_container = $"../../../../ObjectivePanel/ScrollContainer/ObjectiveContainer"
@onready var item_container = $"../../../../InventoryPanel/ItemScroll/ItemContainer"
@onready var memory_container = $"../../../../ActionPanel/VBoxContainer/MemoryContainer"
@onready var action_bar = $"../../../../ActionPanel/VBoxContainer/ActionBar"
@onready var interact_noise = $"../../../../InteractNoise"

@export var schedule : Array[int] = []
@export var NPC_name : String = ""
@export var freeNPC : bool = true
@export_multiline var dialogue_tree : Dictionary = {
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
			}
		},
		"ExampleNode": {
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
					"next_node": "ask_what_they_mean",
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
	}

var current_dialogue_node : String = ""


func _ready():
	text = NPC_name
# Function called when the NPC button is pressed
func _on_pressed():
	disabled = true
	Player.current_npc = NPC_name
	interact_noise.play()
	# Show NPC greeting text in the window
	show_npc_greeting()

	# Create action buttons for each dialogue choice

	create_dialogue_choice_buttons("start")


# Function to create dialogue choice buttons dynamically
func create_dialogue_choice_buttons(node_name):
	var choices = dialogue_tree[node_name]["options"]
	for option_name in choices.keys():
		var dialogue_choice_button = preload("res://Game/NPCS/DialogueAction.tscn").instantiate()

		# Connect the pressed signal to a function that handles the choice
		dialogue_choice_button.connect("pressed", _on_dialogue_choice_selected.bind(option_name))
		action_bar.add_child(dialogue_choice_button)
		dialogue_choice_button.text = choices[option_name]["option_name"]

# Called when a dialogue choice button is selected
func _on_dialogue_choice_selected(option_name):
	# Get the selected choice from the current dialogue node
	var selected_choice = dialogue_tree[current_dialogue_node]["options"][option_name]
	
	# Handle the selected choice
	handle_dialogue_choice(selected_choice)




func handle_dialogue_choice(choice):
	# Display the response text in the window
	display_text_in_window(choice["response_text"])

	# Check for mechanics to change flags, instance new locations, etc.
	if "mechanics" in choice:
		handle_mechanics(choice["mechanics"])

	# Move to the next dialogue node
	move_to_next_node(choice)

	# Debugging: Print the choice dictionary
	print("Choice Dictionary:", choice)


# Function to move to the next dialogue node
func move_to_next_node(choice):
	# Check if the conversation has ended
	if choice["next_node"] == null:
		Player.current_npc = ""
		clear_action_bar()
		if freeNPC == true:
			queue_free()
		else:
			disabled = false
		return
	# Update the current dialogue node
	current_dialogue_node = choice["next_node"]

	# Remove the dialogue choice buttons from the action bar
	clear_action_bar()

	# Create action buttons for the new dialogue node
	create_dialogue_choice_buttons(choice["next_node"])

# Function to show NPC greeting text in the window
func show_npc_greeting():
	current_dialogue_node = "start"
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = (dialogue_tree["start"]["text"])

# Function to handle mechanics (change flags, instance new locations, etc.)
func handle_mechanics(mechanics):
		if "add_item" in mechanics:
			print("adding item", (mechanics["add_item"]))
			if mechanics["add_item"] is Array:
				for i in mechanics["add_item"]:
					var item_to_add = load(i).instantiate()
					item_container.add_child(item_to_add)
					Player.inventory.append(item_to_add.item_name)
			else:
				var item_to_add = load(mechanics["add_item"]).instantiate()
				item_container.add_child(item_to_add)
				Player.inventory.append(item_to_add.item_name)
		#"remove_item": "item_name",
		#"change_location": "location_path",
		if "add_objective" in mechanics: 
			print("adding objective", (mechanics["add_objective"]))
			
			var objective_to_add = load(mechanics["add_objective"]).instantiate()
			objective_to_add.objective = mechanics["objective_text"]
			objective_to_add.objective_description = mechanics["objective_description"]
			objective_container.add_child(objective_to_add)

		#"health_effect": 0,
		#"santiy_effect": 0,
		#"ap_effect": 0,
		#"time_effect": 0,

# Function to clear the dialogue choice buttons from the action bar
func clear_action_bar():
	for child in action_bar.get_children():
		if child.hide_during_npc == false:
			child.queue_free()

# Function to display text in the window (customize as needed)
func display_text_in_window(response_text):
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = response_text


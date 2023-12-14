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

@export var NPC_name : String = ""
var dialogue_tree : Dictionary = {}
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
		queue_free()
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
		child.queue_free()

# Function to display text in the window (customize as needed)
func display_text_in_window(response_text):
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = response_text


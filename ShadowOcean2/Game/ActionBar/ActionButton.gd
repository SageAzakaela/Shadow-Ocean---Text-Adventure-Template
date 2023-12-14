extends Button

@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var navigation_container = $"../../../../NavigationPanel/ScrollContainer/NavigationContainer"
@onready var skill_container = $"../../../../SkillPanel/SkillScroll/SkillContainer"
@onready var remember_mechanic = $"../../MemoryContainer/RememberMechanic"
@onready var item_container = $"../../../../InventoryPanel/ItemScroll/ItemContainer"
@onready var interact_noise = $"../../../../InteractNoise"



#Basic Actions will just use AP and spit out one single predefined bit of text.
#Skill Check will check for a player skill, and if we pass, give us text for that, or if we fail, different text.
#Dialogue Actions (used for NPCs) will run us through branching paths -- Maybe it might be pertinent to use a new node for that?
#RandomNote : As if looking through a pile of notes, picking up just one. 
#Book Actions will create a new set of actions to allow you to read a book/journal
@export var action_type : String = "basic"

@export var destroy_action : bool = false

@export var pass_time : bool = false
@export var time_cost : int = 0

@export var change_location : bool = false
@export var new_location : String = "" #Provide new current location name
@export var exits : Array = [] #provide exit scene paths

@export var action_name : String = ""
@export_multiline var history_text : String = ""

@export var update_player : bool = false

@export var need_ap : bool = true
@export var ap_cost : int = 0
@export var health_effect : int = 0
@export var sanity_effect : int = 0

@export var skill_needed : String = ""
@export var skill_check_history_text : Dictionary = {
	"pass": "",
	"reward_item": "",
	"reward_item_description": "",
	"reward_location": "",
	"reward_skill": "",
	"fail": ""
}

@export var grant_skill : bool = false
@export var skill_to_grant : String = ""


@export var grant_item : bool = false
@export var item_to_grant : String = ""
@export var item_name : String = ""
@export_multiline var item_description : String = ""
@export var item_type : String = "" #Basic, Alchemical, Consumable, Container, Key, Equipment, Weapon,
@export var base_components : Array[String] = []
@export var purity : float = 0.5
@export var item_health_effect : int = 0
@export var item_sanity_effect : int = 0
@export var item_ap_effect : int = 0
@export var item_skill_grant : bool = false
@export var item_skill : String = ""


@export var add_memory : bool = false
@export var add_memory_key : String = ""
@export_multiline var add_memory_context : Array[String] = []
const MEMORY = preload("res://Game/ActionBar/Remember/memory.tscn")




func _ready():
	randomize()
	text = action_name

func _on_pressed():
	if need_ap == true and Player.ap >0:
		interact_noise.play()
		if update_player == true:
			player_update()
		if pass_time == true:
			increment_time()
		if change_location == true:
			location_change()
		if grant_skill == true:
			add_skill_to_player()
		if grant_item == true:
			add_item()
		if add_memory == true:
			add_memory_to_memory_container()
		if action_type == "basic":
			basic_response()
		elif action_type == "skill_check":
			skill_check()
		elif action_type == "random_note":
			basic_response()
			random_note()
		if destroy_action == true:
			queue_free()
	elif need_ap == false:
		interact_noise.play()
		if update_player == true:
			player_update()
		if pass_time == true:
			increment_time()
		if change_location == true:
			location_change()
		if grant_skill == true:
			add_skill_to_player()
		if add_memory == true:
			add_memory_to_memory_container()
		if action_type == "basic":
			basic_response()
		elif action_type == "skill_check":
			skill_check()
		elif action_type == "random_note":
			basic_response()
			random_note()
		if destroy_action == true:
			queue_free()
	else:
		var response_label = preload("res://Game/History/respnse.tscn").instantiate()
		history_container.add_child(response_label)
		response_label.text = "You don't have enough Action Points for that Action.\n\nGet some rest."

func random_note():
	if $RandomNotes.note_array.size() > 0:
		var random_note_text = $RandomNotes.note_array[randi() % $RandomNotes.note_array.size()]
		var last_message = history_container.get_child(1)
		last_message.text = (last_message.text + "\n\n" + random_note_text)
		for n in $RandomNotes.get_children():
			if n.add_skill == true and n.note_text == random_note_text:
				var new_skill = preload("res://Game/Skills/skill.tscn").instantiate()
				new_skill.skill = n.skill_to_add
				new_skill.text = new_skill.skill
				Player.skills.append(new_skill.skill)
				skill_container.add_child(new_skill)
				n.queue_free()
	else:
		print("Error: The note array is empty.")


func skill_check():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	if Player.skills.has(skill_needed):
		history_container.add_child(response_label)
		response_label.text = skill_check_history_text["pass"]
		if skill_check_history_text["reward_item"]:
			var reward = preload("res://Game/Inventory/item.tscn").instantiate()
			reward.item_name = skill_check_history_text["reward_item"]
			reward.item_description = skill_check_history_text["reward_item_description"]
			item_container.add_child(reward)
			queue_free()
			
	else:
		history_container.add_child(response_label)
		response_label.text = skill_check_history_text["fail"]

func basic_response():
		var response_label = preload("res://Game/History/respnse.tscn").instantiate()
		history_container.add_child(response_label)
		response_label.text = history_text

func add_memory_to_memory_container():
	var memory_to_add = MEMORY.instantiate()
	remember_mechanic.add_child(memory_to_add)
	memory_to_add.memory_key = add_memory_key
	memory_to_add.memory_content = add_memory_context
	
func player_update():
	Player.ap -= ap_cost
	Player.health -= health_effect
	Player.sanity -= sanity_effect

func increment_time():
	#Here we'll want to just do our time passage logic on our global_time singleton
	pass

func add_item():
	Player.inventory.append(item_to_grant)
	var item_to_add = preload("res://Game/Inventory/item.tscn").instantiate()
	item_to_add.item_name = item_name
	item_to_add.item_description = item_description
	item_container.add_child(item_to_add)
	item_to_add.item_type = item_type
	item_to_add.base_components = base_components
	item_to_add.health_effect = item_health_effect
	item_to_add.ap_effect = item_ap_effect
	item_to_add.item_skill_grant = item_skill_grant
	item_to_add.item_skill = item_skill

func location_change():
	Player.last_location = Player.current_location
	Player.current_location = new_location
	for child in navigation_container.get_children():
		child.queue_free()
	for exit_path in exits:
		var exit_to_instance = load(exit_path).instantiate()
		navigation_container.add_child(exit_to_instance)

func add_skill_to_player():
	var new_skill = preload("res://Game/Skills/skill.tscn").instantiate()
	skill_container.add_child(new_skill)
	new_skill.skill = skill_to_grant
	new_skill.text = new_skill.skill

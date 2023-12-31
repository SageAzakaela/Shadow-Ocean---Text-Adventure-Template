extends Button

@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var navigation_container = $".."
@onready var npc_container = $"../../../../NPCPanel/ScrollContainer/NPCContainer"
@onready var action_bar = $"../../../../ActionPanel/VBoxContainer/ActionBar"
@onready var interact_noise = $"../../../../InteractNoise"
@onready var things_container = $"../../../../ThingsPanel/ScrollContainer/ThingsContainer"


@export var location : String = ""
@export_multiline var history_text : String = ""
@export var ap_cost : int = 0
@export var time_cost : int = 1
@export var exits : Array[String] = []
@export var NPCS : Array[String] = []
@export var things : Array[String] = []
@export var actions : Array = []
@export var locked : bool = false
@export_multiline var locked_text : String = ""
@export_multiline var unlock_text : String = ""
@export var key : String = ""


func _ready():
	text = location
 
func _process(_delta):
	if Player.current_npc != "":
		disabled = true
	else:
		disabled = false

func _on_pressed():		
	if locked == true:
		if Player.inventory.has(key):
			write_history_unlock()
			locked = false
		else:
			write_history_locked()
	else:
		if Player.ap >= ap_cost:
			Player.last_location = Player.current_location
			Player.current_location = location
			Player.ap -= ap_cost
			write_history()
			spawn_exits()
			spawn_npcs()
			spawn_actions()
			spawn_things()
			GlobalTime.changeTime(time_cost)
			interact_noise.play()
			queue_free()
		else:
			var response_label = preload("res://Game/History/respnse.tscn").instantiate()
			history_container.add_child(response_label)
			response_label.text = "You don't have enough Action Points to go there.\n\nGet some rest."

func write_history_unlock():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = unlock_text
	
func write_history_locked():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = locked_text
	
func write_history():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = history_text


func spawn_things():
	for child in things_container.get_children():
		child.queue_free()
	for things_path in things:
		var thing_to_instance = load(things_path).instantiate()
		things_container.add_child(thing_to_instance)

func spawn_exits():
	for child in navigation_container.get_children():
		child.queue_free()
	for exit_path in exits:
		var exit_to_instance = load(exit_path).instantiate()
		navigation_container.add_child(exit_to_instance)

func spawn_npcs():
	if !NPCS == null:
		for active_NPC in npc_container.get_children():
			active_NPC.queue_free()
		for NPC in NPCS:
			var NPC_to_instance = load(NPC).instantiate()
			npc_container.add_child(NPC_to_instance)
			
func spawn_actions():
	if !actions == null:
		for active_actions in action_bar.get_children():
			active_actions.queue_free()
		for action in actions:
			var action_to_instance = load(action).instantiate()
			action_bar.add_child(action_to_instance)

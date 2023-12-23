extends Button

@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var item_container = $"../../../../InventoryPanel/ItemScroll/ItemContainer"

@export var location : String = ""
@export var thing_name : String = ""
@export var thing_type : String = ""
@export_multiline var thing_content : Array[String] = []
@export var unlock_new_thing : bool = false
@export var unlock_number : int = 0
@export var new_thing : String = ""
@export var grant_random_item : bool = false
@export var random_items : Array[String] = []
# Called when the node enters the scene tree for the first time
var current_thing_index : int = -1
var times_pressed : int = 0

func _ready():
	text = thing_name
	#if thing_type == "shell_collection":
		#for shell in Home.ShellCollection:
			#thing_content.append("You see here several shells, but the one that catches your eye currently is \n\n:"+shell["description"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Player.current_location != location:
		queue_free()


func _on_pressed():
	times_pressed += 1
	if thing_content.size() > 0:
		current_thing_index = (current_thing_index + 1) % thing_content.size()
		var thing_text = thing_content[current_thing_index]
		var response_label = preload("res://Game/History/respnse.tscn").instantiate()
		history_container.add_child(response_label)
		response_label.text = thing_text
	else:
		print("Thing has no content.")
	
	if unlock_new_thing == true and times_pressed >= unlock_number:
		var new_thing_to_instance = load(new_thing).instantiate()
		add_sibling(new_thing_to_instance)
		unlock_new_thing = false
		
	if grant_random_item == true:
		var random_index = randi() % random_items.size()
		var item_to_instance = load(random_items[random_index]).instantiate()
		item_container.add_child(item_to_instance)

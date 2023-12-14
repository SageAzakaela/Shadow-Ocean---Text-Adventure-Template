extends HBoxContainer

@onready var item = $Item
@onready var history_container = $"../../../../HistoryPanel/ScrollContainer/HistoryContainer"
@onready var skill_container = $"../../../../SkillPanel/SkillScroll/SkillContainer"
@onready var objective_container = $"../../../../ObjectivePanel/ScrollContainer/ObjectiveContainer"


@export var item_name : String = ""
@export_multiline var item_description : String = ""
@export var item_type : String = "" #Basic, Alchemical, Consumable, Container, Key, Equipment, Weapon,
@export_multiline var item_used_text : String = ""
@export var base_components : Array[String] = []
@export var purity : float = 0.5
@export var health_effect : int = 0
@export var sanity_effect : int = 0
@export var ap_effect : int = 0
@export var item_skill_grant : bool = false
@export var item_skill : String = ""

func _ready():
	Player.inventory.append(item_name)
	item.text = item_name
	if item_type == "consumable":
		$Use.visible = true
	else:
		$Use.visible = false

func _process(_delta):
	if Player.inventory.has(item_name):
		pass
	else:
		queue_free()

func _on_item_pressed():
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = item_description


func _on_use_pressed():
	Player.health += health_effect
	Player.sanity += sanity_effect
	Player.ap += ap_effect
	if item_skill_grant == true:
		Player.skills.append(item_skill)
		var skill_to_grant = preload("res://Game/Skills/skill.tscn").instantiate()
		skill_container.add_child(skill_to_grant)
		skill_to_grant.text = item_skill
	var response_label = preload("res://Game/History/respnse.tscn").instantiate()
	history_container.add_child(response_label)
	response_label.text = item_used_text
	Player.inventory.erase(item_name)
	queue_free()

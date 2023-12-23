extends Node

@onready var history_panel = $"../../../../../HistoryPanel"
@onready var navigation_panel = $"../../../../../NavigationPanel"
@onready var npc_panel = $"../../../../../NPCPanel"
@onready var objective_panel = $"../../../../../ObjectivePanel"
@onready var info_panel = $"../../../../../InfoPanel"
@onready var inventory_panel = $"../../../../../InventoryPanel"
@onready var skill_panel = $"../../../../../SkillPanel"
@onready var remember_container = $"../../../MemoryContainer"
@onready var locations = $"../../../../../Locations"
@onready var people = $"../../../../../People"
@onready var objectives = $"../../../../../Objectives"
@onready var skills = $"../../../../../Skills"
@onready var inventory = $"../../../../../Inventory"
@onready var image_panel = $"../../../../../ImagePanel"
@onready var title = $"../../../../../Background/Title"
@onready var things_panel = $"../../../../../ThingsPanel"
@onready var things = $"../../../../../Things"
@onready var return_home_bar = $"../../../ReturnHomeBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	return_home_bar.visible = false
	things.visible = false
	things_panel.visible = false
	image_panel.visible = false
	history_panel.visible = false
	navigation_panel.visible = false
	npc_panel.visible = false
	objective_panel.visible = false
	info_panel.visible = false
	inventory_panel.visible = false
	skill_panel.visible = false
	remember_container.visible = false
	locations.visible = false
	people.visible = false
	objectives.visible = false
	skills.visible = false
	inventory.visible = false
	
func _on_action_button_pressed():
	return_home_bar.visible = true
	things.visible = true
	things_panel.visible = true
	title.visible = false
	image_panel.visible = true
	history_panel.visible = true
	navigation_panel.visible = true
	npc_panel.visible = true
	objective_panel.visible = true
	info_panel.visible = true
	inventory_panel.visible = true
	skill_panel.visible = true
	remember_container.visible = true
	locations.visible = true
	people.visible = true
	objectives.visible = true
	skills.visible = true
	inventory.visible = true

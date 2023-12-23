extends Node
@onready var things_container = $"../../../../../ThingsPanel/ScrollContainer/ThingsContainer"

var available_components = []

func _process(_delta):
	if available_components != Home.AlchemyComponents:
		available_components.clear()
		for component in Home.AlchemyComponents:
			available_components.append(component)
			for thing in things_container.get_children():
				if thing.thing_type == "alchemy":
					thing.queue_free()
				else:
					pass
				var thing_to_instance = preload("res://Game/Things/Thing.tscn").instantiate()
				thing_to_instance.thing_name = component
				thing_to_instance.thing_type = "alchemy"
				thing_to_instance.thing_content = ["You see here a vial of mostly pure Ephemeral Currents, be careful with this stuff."]
				things_container.add_child(thing_to_instance)
				

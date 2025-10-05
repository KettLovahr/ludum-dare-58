## Base class for Triggers such as Buttons and Switches
extends Area2D
class_name Trigger

## Items which this trigger will activate
@export var connected_items: Array[Triggerable]

const TRIGGER_TIME = 0.1

signal state_changed(on: bool)

func _ready():
	for item in connected_items:
		state_changed.connect(item._perform_trigger_action)

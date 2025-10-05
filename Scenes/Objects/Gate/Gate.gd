extends Triggerable

@onready var visual = get_parent()
@onready var col = get_parent().get_node("StaticBody2D/CollisionShape2D")

@export var initial_active := false
var active := false
var active_things := 0

func _ready() -> void:
	active = initial_active
	update_activeness()

func _perform_trigger_action(on: bool) -> void:
	if on:
		active_things += 1
	else:
		active_things -= 1
	var activeness = active_things != 0
	active = not initial_active if activeness else initial_active
	update_activeness()

func update_activeness():
	visual.modulate = Color(1.0, 1.0, 1.0, 1.0) if active else Color(1.0, 1.0, 1.0, 0.275)
	col.set_deferred("disabled", not active)

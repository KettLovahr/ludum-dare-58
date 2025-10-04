## Class which is extended by all controllable player parts
extends CharacterBody2D
class_name PlayerPart

const GRAVITY: float = 1000

var kick_state: bool
var kick_curve: Curve2D
var kick_position: float = 0.0
var kick_initial_position: Vector2

var selected: bool:
	get:
		var parent = get_parent()
		if parent is PlayerRoot:
			return parent.selected == self
		return false
		
		
func _physics_process(delta: float) -> void:
	if selected and controllable:
		_handle_controls(delta)
	_custom_behavior(delta)
	move_and_slide()
	
## Override this function with this part's controls
func _handle_controls(delta: float): pass
## Override this function with this part's custom behavior
func _custom_behavior(delta: float): pass
		
func _ready():
	for child in get_children():
		if child is PartSelectionArea:
			child.part_clicked.connect(func(): select())

func select():
	var parent = get_parent()
	if parent is PlayerRoot:
		parent.request_selection(self)

@export var controllable: bool = true

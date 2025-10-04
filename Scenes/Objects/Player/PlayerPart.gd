## Class which is extended by all controllable player parts
extends CharacterBody2D
class_name PlayerPart

@export var sprites: Array[Sprite2D]
@onready var glow_material: Material


const GRAVITY: float = 1000

var selected: bool:
	get:
		var parent = get_parent()
		if parent is PlayerRoot:
			return parent.selected == self
		return false


func _process(delta) -> void:
	glow_material.set_shader_parameter("glowing", self.selected)

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
	# this is stupid but i want the state for these to be different always :/
	glow_material = load("res://Scenes/Objects/Player/Parts/PartGlow.tres").duplicate_deep(Resource.DEEP_DUPLICATE_ALL)
	for child in get_children():
		if child is PartSelectionArea:
			child.part_clicked.connect(func(): select())

func select():
	var parent = get_parent()
	if parent is PlayerRoot:
		parent.request_selection(self)
	for sprite in sprites:
		sprite.material = glow_material

@export var controllable: bool = true

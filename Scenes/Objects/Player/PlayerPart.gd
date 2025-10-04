## Class which is extended by all controllable player parts
extends CharacterBody2D
class_name PlayerPart

const GRAVITY: float = 1000

var selected: bool:
	get:
		var parent = get_parent()
		if parent is PlayerRoot:
			return parent.selected == self
		return false
		
func _ready():
	for child in get_children():
		if child is PartSelectionArea:
			child.part_clicked.connect(func(): select())

func select():
	var parent = get_parent()
	if parent is PlayerRoot:
		parent.request_selection(self)

@export var controllable: bool = true

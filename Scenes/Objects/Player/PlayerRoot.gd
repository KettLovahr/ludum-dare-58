extends Node
class_name PlayerRoot

var selected: PlayerPart

func _ready():
	for child in get_children():
		if child is Skull:
			child.select()
			break

func request_selection(part: PlayerPart):
	if part.controllable and part in get_children():
		selected = part
		set_all_unselected()
		part.selected = true

func set_all_unselected():
	for child in get_children():
		if child is PlayerPart:
			child.selected = false

extends Area2D
class_name PartSelectionArea

signal part_clicked

func _ready():
	pass
	
func _input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouse:
		if event.button_mask & MOUSE_BUTTON_LEFT:
			part_clicked.emit()
	pass

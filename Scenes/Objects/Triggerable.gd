## Parent class for any object that will perform an action when its respective
## switch is pressed
extends Node2D
class_name Triggerable

## Overload this function with object's respective behavior
func _perform_trigger_action(on: bool) -> void:	pass

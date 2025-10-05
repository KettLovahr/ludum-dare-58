extends Trigger
class_name ButtonSwitch

var activated: bool = false

signal button_triggered

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart:
		press()

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerPart:
		pass

func press():
	if activated:
		return
	activated = true
	create_tween()\
		.tween_property($Button, "region_rect", Rect2(0, 0, 92, 16), TRIGGER_TIME)
	await get_tree().create_timer(TRIGGER_TIME).timeout
	button_triggered.emit()
	print("button pressed!")

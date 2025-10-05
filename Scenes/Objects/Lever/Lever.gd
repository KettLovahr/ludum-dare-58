extends Trigger
class_name Lever

var activated: bool = false

signal lever_triggered

func _on_body_entered(body: Node2D) -> void:
	if body is Arm:
		print("fuck")
		body.interact.connect(flip)

func _on_body_exited(body: Node2D) -> void:
	if body is Arm:
		if body.interact.is_connected(flip):
			body.interact.disconnect(flip)

func flip():
	if not activated:
		activated = true
		create_tween()\
			.tween_property($Pivot, "rotation_degrees", 45, TRIGGER_TIME)\
			.set_ease(Tween.EASE_IN)
	await get_tree().create_timer(TRIGGER_TIME).timeout
	lever_triggered.emit()
	print("lever flipped!")

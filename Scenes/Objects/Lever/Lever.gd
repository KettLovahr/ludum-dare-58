extends Trigger
class_name Lever

var activated: bool = false

const OFF_DEGREES = -45
const ON_DEGREES = 45

func _on_body_entered(body: Node2D) -> void:
	if body is Arm:
		body.interact.connect(flip)

func _on_body_exited(body: Node2D) -> void:
	if body is Arm:
		if body.interact.is_connected(flip):
			body.interact.disconnect(flip)

func flip():
	activated = not activated
	create_tween()\
		.tween_property(
			$Pivot,
			"rotation_degrees",
			ON_DEGREES if activated else OFF_DEGREES,
			TRIGGER_TIME)\
		.set_ease(Tween.EASE_IN)
	await get_tree().create_timer(TRIGGER_TIME).timeout
	state_changed.emit(activated)
	print("lever flipped!")

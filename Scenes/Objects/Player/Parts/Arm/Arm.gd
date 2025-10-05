extends PlayerPart
class_name Arm

const MOVE_SPEED = 400

signal interact

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.2)
		
func _handle_controls(delta: float):
	velocity.x = Input.get_axis("move_left", "move_right") * MOVE_SPEED
	if Input.is_action_just_pressed("move_action"):
		interact.emit()

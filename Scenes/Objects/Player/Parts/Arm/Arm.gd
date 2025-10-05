extends PlayerPart
class_name Arm

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.2)

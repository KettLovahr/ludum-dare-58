extends PlayerPart
class_name Arm

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta

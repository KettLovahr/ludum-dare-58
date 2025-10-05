extends PlayerPart
class_name Ribcage

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta

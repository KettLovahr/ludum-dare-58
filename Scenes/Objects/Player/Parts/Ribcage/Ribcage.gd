extends PlayerPart
class_name Ribcage

var climbing: bool = false
var holding: PlayerPart

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta

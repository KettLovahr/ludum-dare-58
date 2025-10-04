extends PlayerPart
class_name Skull

const VELOCITY: float = 1000
	
func _custom_behavior(delta):
	velocity.y += GRAVITY * delta
	$Sprite.rotate(velocity.x / 1000)
	velocity.x = lerp(velocity.x, 0.0, 0.1)
		
func _handle_controls(delta):
	velocity.x += Input.get_axis("move_left", "move_right") * VELOCITY * delta

extends PlayerPart
class_name Skull

const VELOCITY: float = 1000

func _physics_process(delta: float) -> void:
	if selected and controllable:
		_handle_controls(delta)
	velocity.y += GRAVITY * delta
	$Sprite.rotate(velocity.x / 1000)
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	move_and_slide()
		
func _handle_controls(delta):
	velocity.x += Input.get_axis("move_left", "move_right") * VELOCITY * delta

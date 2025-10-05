extends PlayerPart
class_name Skull

const VELOCITY: float = 1500

func _custom_behavior(delta):
	velocity.y += GRAVITY * delta
	$Root/Sprite.rotate(velocity.x / 3500.0)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func _handle_controls(delta):
	if is_on_floor():
		velocity.x += Input.get_axis("move_left", "move_right") * VELOCITY * delta

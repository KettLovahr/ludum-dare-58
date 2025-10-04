extends PlayerPart
class_name Leg

const HOP_DIST = 300
const HOP_HEIGHT = 300

enum Direction {
	LEFT,
	RIGHT
}

func _handle_controls(delta: float):
	if is_on_floor():
		if Input.is_action_pressed("move_left"):
			hop(Direction.LEFT)
		if Input.is_action_pressed("move_right"):
			hop(Direction.RIGHT)
	
func _custom_behavior(delta: float):
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.5)
	velocity.y += GRAVITY * delta
	
func hop(direction: Direction):
	match direction:
		Direction.LEFT:
			velocity.x = -HOP_DIST
		Direction.RIGHT: 
			velocity.x = HOP_DIST
	velocity.y = -HOP_HEIGHT

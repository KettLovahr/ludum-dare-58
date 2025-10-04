extends PlayerPart
class_name Leg

const HOP_DIST = 200
const HOP_HEIGHT = 150
const JUMP_HEIGHT = 500

var can_kick := true

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
		if Input.is_action_just_pressed("move_up"):
			if $KickArea.kick_target != null:
				if can_kick:
					$KickArea.handle_kick()
					$KickDelay.start(1.0)
					can_kick = false
			else:
				velocity.y = -JUMP_HEIGHT
	
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


func _on_kick_delay_timeout() -> void:
	can_kick = true

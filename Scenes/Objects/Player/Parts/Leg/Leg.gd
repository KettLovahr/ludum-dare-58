extends PlayerPart
class_name Leg

const HOP_DIST = 200
const HOP_HEIGHT = 150
const JUMP_HEIGHT = 500

var can_kick := true
var kick_dir: Direction

enum Direction {
	LEFT,
	RIGHT
}

func _handle_controls(delta: float):
	if is_on_floor():
		var axis = Input.get_axis("move_left","move_right")
		velocity.x = Input.get_axis("move_left","move_right") * HOP_DIST
		if axis < 0:
			$Root.scale.x = -1
		elif axis > 0:
			$Root.scale.x = 1
		if Input.is_action_just_pressed("move_action"):
			if $KickArea.kick_target != null:
				if can_kick:
					$KickArea.handle_kick()
					$KickDelay.start(1.0)
					can_kick = false
		if Input.is_action_pressed("move_up"):
			velocity.y = -JUMP_HEIGHT

func _custom_behavior(delta: float):
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.5)
	velocity.y += GRAVITY * delta

func hop(direction: Direction):
	match direction:
		Direction.LEFT:
			velocity.x = -HOP_DIST
			kick_dir = Direction.LEFT
		Direction.RIGHT:
			velocity.x = HOP_DIST
			kick_dir = Direction.LEFT
	velocity.y = -HOP_HEIGHT


func _on_kick_delay_timeout() -> void:
	can_kick = true

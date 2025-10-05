extends PlayerPart
class_name Ribcage

const MOVE_SPEED = 600
const CLIMB_SPEED = 200

var climbing: bool = false
var carrying: PlayerPart

var climbable_areas: Array[ClimbableArea]

func _custom_behavior(delta: float):
	if not climbing:
		velocity.y += GRAVITY * delta

func _handle_controls(delta: float):
	velocity.x = Input.get_axis("move_left", "move_right") *\
		(CLIMB_SPEED if climbing else MOVE_SPEED)
	if climbing:
		velocity.y = Input.get_axis("move_up", "move_down") * CLIMB_SPEED
	if not climbing and Input.is_action_pressed("move_up") and can_climb():
		climbing = true
		
func can_climb() -> bool:
	return len(climbable_areas) > 0

func handle_can_still_climb():
	if not can_climb():
		climbing = false

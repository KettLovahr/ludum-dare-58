extends PlayerPart
class_name Ribcage

const MOVE_SPEED = 600
const CLIMB_SPEED = 200

var climbing: bool = false
var carrying: PlayerPart

var climbable_areas: Array[ClimbableArea]
var detected_parts: Array[PlayerPart]

func _custom_behavior(delta: float):
	if not climbing:
		velocity.y += GRAVITY * delta
	if carrying:
		carrying.global_position = $CarryPivot.global_position

func _handle_controls(delta: float):
	velocity.x = Input.get_axis("move_left", "move_right") *\
		(CLIMB_SPEED if climbing else MOVE_SPEED)
	if climbing:
		velocity.y = Input.get_axis("move_up", "move_down") * CLIMB_SPEED
	if not climbing and Input.is_action_pressed("move_up") and can_climb():
		climbing = true
	if not climbing and not carrying and len(detected_parts) > 0:
		if Input.is_action_just_pressed("move_action"):
			carrying = detected_parts[0]
	elif carrying:
		if Input.is_action_just_pressed("move_action"):
			carrying = null
		
func can_climb() -> bool:
	return len(climbable_areas) > 0

func handle_can_still_climb():
	if not can_climb():
		climbing = false

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is PlayerPart and body is not Ribcage:
		if body not in detected_parts:
			detected_parts.append(body)

func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body is PlayerPart and body is not Ribcage:
		for i in range(len(detected_parts)):
			if detected_parts[i] == body:
				detected_parts.remove_at(i)
				break
		

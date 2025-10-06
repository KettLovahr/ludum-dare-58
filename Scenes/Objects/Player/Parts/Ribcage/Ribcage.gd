extends PlayerPart
class_name Ribcage

const MOVE_SPEED = 400
const CLIMB_SPEED = 200

var climbing: bool = false
var carrying: PlayerPart

var climbable_areas: Array[ClimbableArea]
var detected_parts: Array[PlayerPart]

@onready var root = $Root
@onready var anim = $Root/AnimationPlayer
@onready var climb_root = $Root/Climb

var climb_target_direction: float

@onready var rib_pick: AudioStreamPlayer = $RibPick
@onready var rib_release: AudioStreamPlayer = $RibRelease
@onready var rib_walk: AudioStreamPlayer = $RibWalk

func _custom_behavior(delta: float):
	if not climbing:
		velocity.y += GRAVITY * delta
	if carrying:
		carrying.global_position = $CarryPivot.global_position
		carrying.velocity = Vector2.ZERO
	if not selected or not controllable:
		rib_walk.stop()
		if climbing:
			anim.play("climb_idle")
		else:
			anim.play("side_idle")
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	elif climbing:
		velocity = velocity.lerp(Vector2.ZERO, 0.2)

func _handle_controls(delta: float):
	var x_axis = Input.get_axis("move_left", "move_right")
	var y_axis = Input.get_axis("move_up", "move_down")
	velocity.x = x_axis * (CLIMB_SPEED if climbing else MOVE_SPEED)
	if climbing:
		velocity.y = y_axis * CLIMB_SPEED

	if x_axis != 0 or y_axis != 0:
		if not rib_walk.is_playing():
			rib_walk.play()
			rib_walk.pitch_scale = randf_range(1.0, 1.2)
	else:
		if rib_walk.is_playing():
			rib_walk.stop()

	if not climbing and Input.is_action_pressed("move_up") and can_climb():
		climbing = true
	if not climbing and not carrying and len(detected_parts) > 0:
		if Input.is_action_just_pressed("move_action"):
			carrying = detected_parts[0]
			carrying.z_index = 1
			carrying.being_carried = true
			rib_pick.play()
	elif carrying:
		if Input.is_action_just_pressed("move_action"):
			carrying.z_index = 0
			carrying.being_carried = false
			carrying = null
			rib_release.play()

	if climbing:
		root.scale.x = 1
		if velocity.length() > 0:
			climb_target_direction = atan2(velocity.y, velocity.x) + (PI / 2)
		climb_root.rotation = lerp_angle(climb_root.rotation, climb_target_direction, 0.5)
		if x_axis != 0 or y_axis != 0:
			anim.play("climb_walk")
		else:
			anim.play("climb_idle")
	else:
		if x_axis > 0:
			root.scale.x = 1
			anim.play("side_walk")
		elif x_axis < 0:
			root.scale.x = -1
			anim.play("side_walk")
		else:
			anim.play("side_idle")

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

extends PlayerPart
class_name Arm

const MOVE_SPEED = 400

@export var ArmSound: AudioStreamPlayer
@onready var anim = $Root/AnimationPlayer

signal interact

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	if not selected or not controllable:
		anim.play("idle")
		if ArmSound.playing:
			ArmSound.stop()

func _handle_controls(_delta: float):
	var axis = Input.get_axis("move_left", "move_right")
	velocity.x = axis * MOVE_SPEED
	if axis < 0:
		$Root.scale.x = -1
		anim.play("walk")
	elif axis > 0:
		$Root.scale.x = 1
		anim.play("walk")
	else:
		anim.play("idle")
	PlaySound()
	if Input.is_action_just_pressed("move_action"):
		interact.emit()

func PlaySound():
	var IsMoving = Input.get_axis("move_left", "move_right")
	if IsMoving and ArmSound:
		if not ArmSound.is_playing():
			ArmSound.play()
	else:
		ArmSound.stop()

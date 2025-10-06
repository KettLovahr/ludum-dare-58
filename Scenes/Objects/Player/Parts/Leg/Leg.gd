extends PlayerPart
class_name Leg

const HOP_DIST = 400
const HOP_HEIGHT = 150
const JUMP_HEIGHT = 550

var can_kick := true
var kick_dir: Direction

var facing: Direction = Direction.RIGHT

@onready var KickSound: AudioStreamPlayer = $KickSound
@onready var col = $CollisionShape2D
@onready var col_when_kicked = $CollisionShapeWhenKicked

enum Direction {
	LEFT,
	RIGHT
}

@onready var anim = $Root/AnimationPlayer
@onready var left_kick = $KickArea/Left
@onready var right_kick = $KickArea/Right

func _handle_controls(_delta: float):
	if is_on_floor():
		if anim.current_animation == "kick":
			return
		var axis = Input.get_axis("move_left","move_right")
		velocity.x = Input.get_axis("move_left","move_right") * HOP_DIST
		if axis < 0:
			$Root.scale.x = -1
			anim.play("walk")
			facing = Direction.LEFT
			left_kick.set_deferred("disabled", false)
			right_kick.set_deferred("disabled", true)
		elif axis > 0:
			$Root.scale.x = 1
			anim.play("walk")
			facing = Direction.RIGHT
			left_kick.set_deferred("disabled", true)
			right_kick.set_deferred("disabled", false)
		else:
			anim.play("idle")
		if Input.is_action_just_pressed("move_action"):
			if $KickArea.kick_target != null:
				if can_kick:
					anim.play("kick")
		if Input.is_action_pressed("move_up"):
			anim.play("jump")
			if $WalkSound.is_playing():
				$WalkSound.stop()
			$JumpSound.play()
			velocity.y = -JUMP_HEIGHT

func _custom_behavior(delta: float):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	elif not selected:
		if velocity.y < 0:
			col_when_kicked.set_deferred("disabled", false)
			col.set_deferred("disabled", true)
		else:
			col_when_kicked.set_deferred("disabled", true)
			col.set_deferred("disabled", false)
	if not selected or not controllable:
		anim.play("idle")

func kick():
	KickSound.pitch_scale = randf_range(0.8, 1.2)
	$KickArea.handle_kick()
	$KickDelay.start(1.0)
	can_kick = false


func _on_kick_delay_timeout() -> void:
	can_kick = true

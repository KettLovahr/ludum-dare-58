extends PlayerPart
class_name Skull

const VELOCITY: float = 1500

@onready var anim := $Root/AnimationPlayer
var kick_anim_delay_passed := true

func _custom_behavior(delta):
	velocity.y += GRAVITY * delta
	$Root/Sprite.rotate(velocity.x / 3500.0)
	if is_on_floor():
		if kick_anim_delay_passed:
			anim.play("idle")
		velocity.x = lerp(velocity.x, 0.0, 0.1)

func _handle_controls(delta):
	if is_on_floor():
		velocity.x += Input.get_axis("move_left", "move_right") * VELOCITY * delta

func _handle_kicked():
	kick_anim_delay_passed = false
	anim.play("kick")
	await get_tree().create_timer(0.2).timeout
	kick_anim_delay_passed = true

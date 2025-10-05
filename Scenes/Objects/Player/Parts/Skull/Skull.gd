extends PlayerPart
class_name Skull

const VELOCITY: float = 1500

@onready var col = $CollisionShape2D
@onready var col_when_kicked = $CollisionShapeWhenKicked

func _custom_behavior(delta):
	velocity.y += GRAVITY * delta
	$Root/Sprite.rotate(velocity.x / 3500.0)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.1)
	else:
		if velocity.y < 0:
			col_when_kicked.set_deferred("disabled", false)
			col.set_deferred("disabled", true)
		else:
			col_when_kicked.set_deferred("disabled", true)
			col.set_deferred("disabled", false)

func _handle_controls(delta):
	if is_on_floor():
		velocity.x += Input.get_axis("move_left", "move_right") * VELOCITY * delta

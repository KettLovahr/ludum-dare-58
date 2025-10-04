extends Area2D
class_name KickArea

var kick_target: PlayerPart
var curve: Curve2D = Curve2D.new()

func _ready():
	generate_curve(1)
	%TrajectoryArc.curve = curve

func _process(delta: float) -> void:
	if kick_target != null:
		var strength = kick_target.global_position.x - global_position.x
		generate_curve(strength)
		%TrajectoryArc.global_position = kick_target.global_position
		
func generate_curve(strength: float):
	var dist = strength * 2
	var height = abs(strength)
	curve.clear_points()
	curve.add_point( Vector2.ZERO )
	curve.add_point( Vector2(dist, -height), Vector2(-dist/2, 0), Vector2(dist/2, 0) )
	curve.add_point( Vector2(dist*2, 0) )
	
func handle_kick():
	print(curve.point_count)
	kick_target.global_position.y -= 16
	kick_target.move_and_slide()
	kick_target.kick_curve = curve.duplicate(true)
	kick_target.kick_initial_position = kick_target.global_position
	kick_target.kick_state = true
	
	kick_target = null
	%TrajectoryArc.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart and body != get_parent() and kick_target == null:
		kick_target = body
		%TrajectoryArc.show()

func _on_body_exited(body: Node2D) -> void:
	if body == kick_target:
		kick_target = null
		%TrajectoryArc.hide()

extends Area2D
class_name KickArea

var kick_target: PlayerPart
var curve: Curve2D = Curve2D.new()

var dist: float
var height: float

func _ready():
	generate_curve(1, 1.0/60)
	%TrajectoryArc.curve = curve

func _process(delta: float) -> void:
	if kick_target != null:
		var strength = kick_target.global_position.x - global_position.x
		generate_curve(strength, delta)
		%TrajectoryArc.global_position = kick_target.global_position
		
func generate_curve(strength: float, delta: float):
	dist = strength * 6
	height = abs(strength) * 6
	curve.clear_points()
	curve.add_point( Vector2.ZERO )
	# just simulate the whole path i guess idfk
	var yvel = -height
	var yp = yvel * delta
	for i in range(abs(strength) + 1):
		curve.add_point(Vector2(dist * i * delta, yp))
		yp += yvel * delta
		yvel += PlayerPart.GRAVITY * delta
	
func handle_kick():
	kick_target.velocity.x = dist
	kick_target.velocity.y = -height
	%TrajectoryArc.hide()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart and body != get_parent() and kick_target == null:
		kick_target = body
		%TrajectoryArc.show()

func _on_body_exited(body: Node2D) -> void:
	if body == kick_target:
		kick_target = null
		%TrajectoryArc.hide()

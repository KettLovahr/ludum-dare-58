extends Area2D
class_name KickArea

var kick_target: PlayerPart
var curve: Curve2D = Curve2D.new()

var dist: float
var height: float

var valid_kick: bool = false

func _ready():
	generate_curve(1, 1.0/60)
	%TrajectoryArc.curve = curve

func _process(delta: float) -> void:
	if kick_target != null:
		var strength = kick_target.global_position.x - global_position.x
		valid_kick = generate_curve(strength, delta)
		%TrajectoryArc.global_position = kick_target.global_position
	%TrajectoryArc.visible = (kick_target != null)\
		and get_parent().can_kick\
		and valid_kick
		
func generate_curve(strength: float, delta: float) -> bool:
	var parent: Leg = get_parent()
	if parent.facing == Leg.Direction.LEFT and strength > 0\
		or parent.facing == Leg.Direction.RIGHT and strength < 0:
			return false
	dist = strength * 6
	height = abs(strength) * 6
	if kick_target:
		dist *= kick_target.kick_strength_factor
		height *= kick_target.kick_strength_factor
	curve.clear_points()
	curve.add_point( Vector2.ZERO )
	# just simulate the whole path i guess idfk
	var yvel = -height
	var yp = yvel * delta
	for i in 50:
		curve.add_point(Vector2(dist * i * delta, yp))
		yp += yvel * delta
		yvel += PlayerPart.GRAVITY * delta
	return true
	
func handle_kick():
	kick_target.velocity.x = dist
	kick_target.velocity.y = -height

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart and body != get_parent() and kick_target == null:
		kick_target = body

func _on_body_exited(body: Node2D) -> void:
	if body == kick_target:
		kick_target = null

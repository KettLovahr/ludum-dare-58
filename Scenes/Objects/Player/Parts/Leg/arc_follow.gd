extends Path2D

const points: int = 10

@export var trajectory_gradient: Gradient

var tinies: Array[PathFollow2D]
var offset := 0.0

func _ready():
	for i in range(points):
		create_tiny_sprite(i)


func _process(delta):
	offset += delta / 10
	if curve.get_baked_length() > 0:
		for i in range(points):
			var point_pos: float = fmod(((1.0 / points) * i) + offset, 1.0)
			tinies[i].progress_ratio = point_pos
			tinies[i].modulate = trajectory_gradient.sample(point_pos)

func create_tiny_sprite(i: int):
	var new_pathfollow := PathFollow2D.new()
	var new_spr := Sprite2D.new()
	new_spr.texture = load("res://Assets/Environment/Coin.png")
	new_spr.scale = Vector2(0.1, 0.1)
	if i % 3 == 0:
		new_spr.scale *= 1.5
	add_child(new_pathfollow)
	new_pathfollow.add_child(new_spr)
	tinies.append(new_pathfollow)

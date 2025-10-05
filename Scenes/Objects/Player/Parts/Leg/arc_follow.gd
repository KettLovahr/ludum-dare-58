extends Path2D

const points: int = 10

var tinies: Array[PathFollow2D]
var offset := 0.0

func _ready():
	for i in range(points):
		create_tiny_sprite()


func _process(delta):
	offset += delta / 10
	if curve.get_baked_length() > 0:
		for i in range(points):
			tinies[i].progress_ratio = fmod(((1.0 / points) * i) + offset, 1.0)

func create_tiny_sprite():
	var new_pathfollow := PathFollow2D.new()
	var new_spr := Sprite2D.new()
	new_spr.texture = load("res://Assets/Environment/Coin.png")
	new_spr.scale = Vector2(0.1, 0.1)
	add_child(new_pathfollow)
	new_pathfollow.add_child(new_spr)
	tinies.append(new_pathfollow)

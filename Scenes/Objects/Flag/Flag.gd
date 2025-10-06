extends Area2D
class_name Flag

signal flag_reached

var parts_reached: Array[PlayerPart]
@export var player_root: PlayerRoot
var target_count: int
var won := false

func _ready():
	target_count = len(player_root.get_children().filter(func(x): return x is PlayerPart))

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart and body not in parts_reached:
		$AnimationPlayer.play("blip")
		parts_reached.append(body)
		$PartReached.play()
		$PartReached.pitch_scale = 1.0 + (len(parts_reached) / 10.0)
	if len(parts_reached) == target_count and not won:
		won = true
		flag_reached.emit()
		$LevelComplete.play()

func _on_body_exited(body: Node2D) -> void:
	for i in range(len(parts_reached)):
		if parts_reached[i] == body:
			parts_reached.remove_at(i)
			break

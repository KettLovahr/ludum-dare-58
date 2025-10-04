extends Area2D
class_name Coin

signal collected

var active: bool = true

const TIME = 0.4

func _on_body_entered(body: Node2D) -> void:
	print("hewo")
	if body is PlayerPart and active:
		collected.emit()
		active = false
		create_tween().tween_property(self, "modulate", Color.TRANSPARENT, TIME)
		await get_tree().create_timer(TIME).timeout
		queue_free()

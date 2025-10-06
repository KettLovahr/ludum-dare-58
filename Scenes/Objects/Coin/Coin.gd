extends Area2D
class_name Coin

signal collected

var active: bool = true

const TIME = 0.4

@onready var anim: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart and active:
		collected.emit()
		active = false
		$CoinSFX.play()
		anim.play("Coin/CoinCollect")
		await anim.animation_finished
		queue_free()

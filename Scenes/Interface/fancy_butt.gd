extends Button


@onready var anim = $AnimationPlayer
var is_button_down := false
var is_mouse_over := false


func _on_mouse_entered() -> void:
	is_mouse_over = true
	anim.play("hover")

func _on_mouse_exited() -> void:
	is_mouse_over = false
	if not is_button_down:
		anim.play("normal")

func _on_button_down() -> void:
	is_button_down = true
	anim.play("press")

func _on_button_up() -> void:
	is_button_down = false
	if is_mouse_over:
		anim.play("hover")
	else:
		anim.play("normal")

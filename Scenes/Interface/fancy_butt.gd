extends Button


@onready var anim = $AnimationPlayer
var is_button_down := false
var is_mouse_over := false


func _on_mouse_entered() -> void:
	is_mouse_over = true
	if disabled or button_pressed:
		return
	anim.play("hover")

func _on_mouse_exited() -> void:
	is_mouse_over = false
	if disabled or button_pressed:
		return
	if not is_button_down:
		anim.play("normal")

func _on_button_down() -> void:
	is_button_down = true
	if disabled:
		return
	anim.play("press")

func _on_button_up() -> void:
	is_button_down = false
	if disabled or button_pressed:
		return
	if is_mouse_over:
		anim.play("hover")
	else:
		anim.play("normal")

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		anim.play("toggled")

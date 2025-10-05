extends Control


const SQUARE_BUTT = preload("res://Scenes/Interface/square_butt.tscn")


func _ready() -> void:
	var grid = $Levels/GridContainer
	var i := 0
	for path in GameState.level_scene_paths:
		var butt := SQUARE_BUTT.instantiate() as Button
		butt.get_node("Label").text = str(i + 1)
		butt.pressed.connect(func():
			GameState.current_level = i
			Transition.change_scene_to_file(path)
		)
		if GameState.unlocked < i:
			butt.modulate = Color(1.0, 1.0, 1.0, 0.25)
			butt.disabled = true
		grid.add_child(butt)
		i += 1


func _on_start_pressed() -> void:
	$Main/AnimationPlayer.play("out")
	await $Main/AnimationPlayer.animation_finished
	$Levels/AnimationPlayer.play("in")


func _on_main_menu_pressed() -> void:
	$Levels/AnimationPlayer.play("out")
	await $Levels/AnimationPlayer.animation_finished
	$Main/AnimationPlayer.play("in")

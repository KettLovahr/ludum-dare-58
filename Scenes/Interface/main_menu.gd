extends Control


const SQUARE_BUTT = preload("res://Scenes/Interface/square_butt.tscn")
const GRAVE_COMPLETE = preload("res://Assets/Interface/TombstoneCompleted.png")


func _ready() -> void:
	var grid = $Levels/GridContainer
	var i := 0
	for path in GameState.level_scene_paths:
		var butt := SQUARE_BUTT.instantiate() as Button
		butt.get_node("Label").text = str(i + 1)
		butt.get_node("Graves").show()
		for j in range(3):
			if GameState.tombstones_state[i][j]:
				butt.get_node("Graves/Grave" + str(j + 1)).texture = GRAVE_COMPLETE
		butt.pressed.connect(func():
			GameState.current_level = i
			Transition.change_scene_to_file(path)
		)
		if GameState.unlocked < i:
			butt.modulate = Color(1.0, 1.0, 1.0, 0.25)
			butt.disabled = true
		grid.add_child(butt)
		i += 1


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cheat"):
		GameState.unlocked = len(GameState.level_scene_paths) - 1
		Transition.reload_current_scene()


func _on_start_pressed() -> void:
	$Main/AnimationPlayer.play("out")
	await $Main/AnimationPlayer.animation_finished
	$Levels/AnimationPlayer.play("in")


func _on_main_menu_pressed() -> void:
	$Levels/AnimationPlayer.play("out")
	await $Levels/AnimationPlayer.animation_finished
	$Main/AnimationPlayer.play("in")


func _on_instructions_pressed() -> void:
	$Main/AnimationPlayer.play("out")
	await $Main/AnimationPlayer.animation_finished
	$Instructions/AnimationPlayer.play("in")


func _on_main_menu_2_pressed() -> void:
	$Instructions/AnimationPlayer.play("out")
	await $Instructions/AnimationPlayer.animation_finished
	$Main/AnimationPlayer.play("in")


func _on_credits_pressed() -> void:
	$Levels/AnimationPlayer.play("out")
	await $Levels/AnimationPlayer.animation_finished
	$Credits/AnimationPlayer.play("in")


func _on_back_pressed() -> void:
	$Credits/AnimationPlayer.play("out")
	await $Credits/AnimationPlayer.animation_finished
	$Levels/AnimationPlayer.play("in")

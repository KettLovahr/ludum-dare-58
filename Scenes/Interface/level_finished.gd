extends CanvasLayer


var next_level := ""
var _grave_states := [false, false, false]


func complete(grave_states: Array, time_limit: float):
	var which_level = GameState.current_level
	if which_level + 1 >= len(GameState.level_scene_paths):
		$Next.hide()
	else:
		next_level = GameState.level_scene_paths[which_level + 1]
	_grave_states = grave_states

	var sec_num = floor(time_limit)
	var minutes = floor(sec_num / 60)
	var seconds = floor(sec_num - minutes * 60)
	$Grave3/Label.text = str(int(minutes)).pad_zeros(2) + ':' + str(int(seconds)).pad_zeros(2)

	$AnimationPlayer.play("in")
	if GameState.unlocked == which_level:
		GameState.unlocked += 1


func _on_next_pressed() -> void:
	GameState.current_level += 1
	Transition.change_scene_to_file(next_level)


func check_grave(which: int):
	if which < 0 or which > 2 or not _grave_states[which]:
		return
	get_node("Grave" + str(which + 1) + "/AnimationPlayer").play("complete")


func _on_main_menu_pressed() -> void:
	Transition.change_scene_to_file("res://Scenes/Interface/main_menu.tscn")


func _on_restart_pressed() -> void:
	Transition.reload_current_scene()

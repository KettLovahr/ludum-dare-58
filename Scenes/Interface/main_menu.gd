extends Control


@export_file_path() var level_scene_paths: Array[String]
const SQUARE_BUTT = preload("res://Scenes/Interface/square_butt.tscn")


func _ready() -> void:
	var grid = $Levels/GridContainer
	var i := 1
	for path in level_scene_paths:
		var butt := SQUARE_BUTT.instantiate() as Button
		butt.get_node("Label").text = str(i)
		butt.pressed.connect(func(): get_tree().change_scene_to_file(path))
		grid.add_child(butt)


func _on_start_pressed() -> void:
	$Main/AnimationPlayer.play("out")
	await $Main/AnimationPlayer.animation_finished
	$Levels/AnimationPlayer.play("in")


func _on_main_menu_pressed() -> void:
	$Levels/AnimationPlayer.play("out")
	await $Levels/AnimationPlayer.animation_finished
	$Main/AnimationPlayer.play("in")

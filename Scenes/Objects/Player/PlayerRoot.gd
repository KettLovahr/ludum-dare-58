extends Node
class_name PlayerRoot

var selected: PlayerPart
signal selection_changed(part: PlayerPart)

const BONE_BUTT = preload("res://Scenes/Interface/bone_button.tscn")
var mapped_parts: Array[PlayerPart]
var created_arm := false
var created_leg := false
var disabled := false:
	set(new):
		for part in mapped_parts:
			part.controllable = not new
		disabled = new

@onready var SelectSFX: AudioStreamPlayer = $SelectPart

func _ready():
	var i = 0
	for child in get_children():
		if child is PlayerPart:
			create_button_for(child, i)
			i += 1
		if child is Skull:
			child.select()

func _process(_delta):
	for i in range(1, len(mapped_parts) + 1):
		if Input.is_action_just_pressed("switch_%s" % [i]):
			mapped_parts[i-1].select()

func request_selection(part: PlayerPart):
	if part.controllable and part in get_children():
		selected = part
		SelectSFX.play()
		SelectSFX.pitch_scale = randf_range(0.8, 1.2)
		set_all_unselected()
		part.selected = true
		selection_changed.emit(part)

func set_all_unselected():
	for child in get_children():
		if child is PlayerPart:
			child.selected = false
	for child in $PlayerUICanvas/PlayerUI/PartsButtons.get_children():
		child.button_pressed = false
		child.anim.play("normal")

func create_button_for(part: PlayerPart, number: int):
	mapped_parts.append(part)
	var new_button: Button = BONE_BUTT.instantiate()
	# Use names Skull Leg1 Leg2 Arm1 Arm2 Ribcage for bone nodes
	var texture = load("res://Assets/Interface/Bone" + part.name + ".png")
	new_button.get_node("TextureRect").texture = texture
	new_button.get_node("Label").text = str(number + 1)
	new_button.pressed.connect(func(): part.select())
	selection_changed.connect(func(np):
		if np == part:
			new_button.button_pressed = true
	)
	$PlayerUICanvas/PlayerUI/PartsButtons.add_child(new_button)


func _on_restart_pressed() -> void:
	Transition.reload_current_scene()


func _on_levels_pressed() -> void:
	Transition.change_scene_to_file("res://Scenes/Interface/main_menu.tscn")

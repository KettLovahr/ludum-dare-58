extends Node
class_name PlayerRoot

var selected: PlayerPart
signal selection_changed(part: PlayerPart)

var mapped_parts: Array[PlayerPart]

func _ready():
	for child in get_children():
		if child is Skull:
			child.select()
		if child is PlayerPart:
			create_button_for(child)

func _process(delta):
	for i in range(1, len(mapped_parts) + 1):
		if Input.is_action_just_pressed("switch_%s" % [i]):
			mapped_parts[i-1].select()

func request_selection(part: PlayerPart):
	if part.controllable and part in get_children():
		selected = part
		set_all_unselected()
		part.selected = true
		selection_changed.emit(part)

func set_all_unselected():
	for child in get_children():
		if child is PlayerPart:
			child.selected = false

func create_button_for(part: PlayerPart):
	mapped_parts.append(part)
	var new_button: Button = Button.new()
	new_button.text = part.name
	new_button.pressed.connect(func(): part.select())
	selection_changed.connect(func(np): pass) # define function for when own button is selected
	$PlayerUICanvas/PlayerUI/PartsButtons.add_child(new_button)

extends TextureRect

@export var columns : int = 4
@export var sep : Vector2i = Vector2i(20, 20)

var text_option := preload("res://Scenes/text_option.tscn") as PackedScene
var current_options : Array[Button] = []
var current_string_index = 0

@onready var grid := %GridContainer as GridContainer

signal display(scene : PackedScene)

func create_text_options(text_resources : Array[TextOptionResource]):
	grid.columns = columns
	grid.add_theme_constant_override("h_separation", sep.x)
	grid.add_theme_constant_override("v_separation", sep.y)
	for i in range(text_resources.size()):
		var new_option = text_option.instantiate()
		new_option.text_option_resource = text_resources[i]
		new_option.update()
		grid.add_child(new_option)

func choose_strings(charc : String):
	for i in range(grid.get_child_count()):
		var tmp = grid.get_child(i)
		if tmp.text_option_resource.text[0] == charc:
			current_options.append(tmp)
			tmp.button_pressed = true
	if current_options.is_empty():
		return false
	current_string_index += 1
	return true

func manage_input(charc : String):
	if current_options.is_empty():
		return int(choose_strings(charc))
	if check_current_strings(charc):
		current_string_index += 1
		if current_options.size() == 1 and current_string_index >= current_options[0].text_option_resource.text.length():
			current_string_index = 0
			display.emit(current_options[0].text_option_resource.display_scene)
			current_options[0].call_deferred("queue_free")
			current_options = []
			return 2
		return 1
	current_string_index = 0
	return 0

func check_current_strings(charc : String):
	var new_strings : Array[Button] = []
	for node in current_options:
		if node.text_option_resource.text[current_string_index] == charc:
			new_strings.append(node)
		else:
			node.button_pressed = false
	current_options = new_strings
	return not current_options.is_empty()

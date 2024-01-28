extends TextureRect

var generic_menu_scene := preload("res://UI/generic_menu.tscn") as PackedScene

func _ready():
	%StartButton.grab_focus()

func _on_start_button_pressed():
	Globals.start()

func _on_level_button_pressed():
	get_tree().change_scene_to_file("res://UI/level_menu.tscn")

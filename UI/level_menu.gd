extends TextureRect

func _ready():
	%MainMenuButton.grab_focus()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

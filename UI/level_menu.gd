extends TextureRect

var new_icon = preload("res://Assets/broken.png")

func _ready():
	%MainMenuButton.grab_focus()
	var lvl_container = %LevelContainer as GridContainer
	for i in range(Globals.max_levels):
		var new_button := Button.new()
		new_button.text = "Nivel " + str(i+1)
		new_button.icon = new_icon
		new_button.add_theme_font_size_override("font_size", 25)
		new_button.connect("pressed", change_to_level.bind(i))
		lvl_container.add_child(new_button)

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

func change_to_level(lvl : int):
	Globals.show_tutorial = false
	Globals.current_level = lvl
	Globals.next_level()

extends ColorRect

@onready var title_label := %Title as Label
@onready var button_node := %Buttons as GridContainer

func add_buttons(text, callables):
	for i in range(min(text.size(), callables.size())):
		var new_button := Button.new()
		new_button.text = text[i]
		new_button.connect("pressed", callables[i])
		new_button.add_theme_font_size_override("font_size", 25)
		new_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button_node.add_child(new_button)
		if i == 0:
			new_button.grab_focus()

func change_title(txt : String):
	title_label.text = txt

func add_labels(text):
	for i in range(text.size()):
		var new_label := Label.new()
		new_label.text = text[i]
		new_label.add_theme_font_size_override("font_size", 25)
		new_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		button_node.add_child(new_label)

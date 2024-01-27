@tool
class_name ReplaceTextEffect
extends RichTextEffect

@export var current_char_index = 0
@export var finished = false
# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
# - Use [replace param=2.0]hello[/replace] in text.
var bbcode = "replace"

func _process_custom_fx(char_fx):
	if finished:
		char_fx.color = Color(0, 1, 0)
		return true
	if char_fx.relative_index < current_char_index:
		char_fx.color.a = 0.5
	return true

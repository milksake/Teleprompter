@tool
# Having a class name is handy for picking the effect in the Inspector.
class_name RichTextShineTextEffect
extends RichTextEffect

# To use this effect:
# - Enable BBCode on a RichTextLabel.
# - Register this effect on the label.
# - Use [shine_text_effect param=2.0]hello[/shine_text_effect] in text.
var bbcode = "shine"

func _process_custom_fx(char_fx):
	# Get parameters, or use the provided default value if missing.
	var speed = char_fx.env.get("freq", 2.0)
	var span = char_fx.env.get("span", 12.0)

	var alpha = sin(char_fx.elapsed_time * speed + (char_fx.range.x / span)) * 0.2 - 0.2
	char_fx.color += Color(alpha, alpha, alpha)
	return true

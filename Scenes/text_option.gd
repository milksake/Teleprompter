extends Button

@export var text_option_resource : TextOptionResource

func update():
	text = text_option_resource.text

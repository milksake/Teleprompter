extends RichTextLabel

var text_index := 0
var text_list : PackedStringArray
var current_unformatted_text : String
@onready var timer := $Timer as Timer
@onready var bips : Array[AudioStreamPlayer] = [$bip1, $bip2, $bip3, $bip4]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", add_char)
	#initialize_variables("[color=green]TAAAAAAAAAAAAa[/color]. Hola")

func add_char():
	if visible_characters < current_unformatted_text.length():
		if current_unformatted_text[visible_characters] != ' ':
			bips[randi() % bips.size()].play()
		visible_characters += 1
	else:
		timer.stop()
		await get_tree().create_timer(0.25).timeout
		visible_characters = 0
		text_index += 1
		if text_index >= text_list.size():
			return
		timer.start()
		text = text_list[text_index] + ("." if text_index < text_list.size()-1 else "")
		current_unformatted_text = get_parsed_text()

func initialize_variables(new_text: String):
	new_text = new_text.lstrip(" \t\r\n").rstrip(" \t\r\n")
	text_list = new_text.split(". ")
	text_index = 0
	text = text_list[text_index] + "."
	current_unformatted_text = get_parsed_text()
	visible_characters = 0
	text_index = 0
	timer.stop()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped() and text_index >= text_list.size():
		timer.stop()

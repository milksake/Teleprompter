extends Label

var text_index := 0
var text_length := 0
var text_string := ""
@onready var timer := $Timer as Timer
@onready var bips : Array[AudioStreamPlayer] = [$bip1, $bip2, $bip3, $bip4]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", add_char)
	add_text("hola papus")

func add_char():
	if text_index < text_string.length():
		if text_string[text_index] == ' ':
			if text_length > 20:
				text_length = 0
				text += '\n'
			else:
				text_length += 1
				text += ' '
		else:
			bips[randi() % bips.size()].play()
			text += text_string[text_index]
			text_length += 1
			
		text_index += 1

func add_text(new_text: String):
	text = ""
	text_string = new_text
	text_length = 0
	text_index = 0
	timer.stop()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped() and text_index >= text_string.length():
		timer.stop()

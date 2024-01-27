extends Node2D

@export var text_script : ScriptResource

var finished_scrolling = false
var finished_input = false

@onready var tele := %Tele

func _ready():
	finished_input = tele.initialize_values(text_script.text)

func _process(delta):
	if not finished_scrolling:
		finished_scrolling = tele.move_slider(delta)

func _input(event):
	if finished_input:
		return
	if event is InputEventKey and event.is_pressed():
		if "a".unicode_at(0) <= event.unicode and event.unicode <= "z".unicode_at(0):
			tele.manage_input(char(event.unicode))
	if event.is_action_pressed("ui_down"):
		finished_input = tele.next_word()

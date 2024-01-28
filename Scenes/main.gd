extends Node

@export var text_script : ScriptResource

var finished_scrolling = false
var finished_input = false
var disable = false
var generic_menu_scene := preload("res://UI/generic_menu.tscn") as PackedScene

@onready var tele := %Tele
@onready var word_bank := %WordBank
@onready var text_bubble := $TextBubble
@onready var menu_canvas := %MenuCanvas
@onready var key_audio := %KeyAudio
@onready var screen_nodes := %ScreenNodes

func _ready():
	if text_script == null:
		text_script = load("res://LevelResources/level_" + Globals.current_level + ".tres")
	finished_input = tele.initialize_values(text_script.text)
	word_bank.create_text_options(text_script.word_bank)
	if text_script.background != null:
		var back = text_script.background.instantiate()
		screen_nodes.add_child(back)

func _process(delta):
	if (finished_input or finished_scrolling) and not disable:
		disable = true
		finished_input = true
		text_bubble.add_text(tele.label.get_parsed_text())
		var t := create_tween()
		t.tween_property(%Music, "volume_db", -20, 1)
		create_finish_menu()
		
	if not finished_scrolling:
		finished_scrolling = tele.move_slider(delta)

func _input(event):
	if finished_input:
		return
	if event is InputEventKey and event.is_pressed():
		if "a".unicode_at(0) <= event.unicode and event.unicode <= "z".unicode_at(0) or " ".unicode_at(0) == event.unicode:
			var code = word_bank.manage_input(char(event.unicode))
			if code == 0:
				tele.erase_current_word()
				return
			tele.manage_input(char(event.unicode))
			key_audio.get_children().pick_random().play()
			if code == 2:
				finished_input = tele.next_word()
				if finished_input:
					tele.vertical_speed *= 10

func create_finish_menu():
	var new_menu = generic_menu_scene.instantiate()
	menu_canvas.add_child(new_menu)
	new_menu.change_title("Noticiero Terminado")
	var score = tele.calculate_score()
	new_menu.add_labels([("Puntaje: " + str(score[0]) + "/" + str(score[1]))])
	new_menu.add_buttons(["Siguiente Nivel", "Repetir", "Menu Principal"], [Globals.next_level, Globals.restart_level, func(): get_tree().call_deferred('change_scene_to_file', "res://UI/main_menu.tscn")])

func _on_word_bank_display(scene):
	if scene == null:
		return
	var new_scene = scene.instantiate()
	new_scene.position = Vector2(text_script.positions[tele.current_index])
	screen_nodes.add_child(new_scene)

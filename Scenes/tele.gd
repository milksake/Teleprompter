extends TextureRect

@export_range(15.0, 100.0) var vertical_speed : float = 50
@export var form_prev : String = "[color=red]|[/color]"
@export var form_during : String = "[color=yellow]|[/color]"
@export var form_after : String = "[color=green]|[/color]"
@export var padd = 10

var splitted_text : PackedStringArray
var correct_words : Array[String]
var current_index : int = 0
var edited = false
var unformated_strings : Array[String]
var scroll_pos : float = 1.0

var list_form_prev : PackedStringArray
var list_form_during : PackedStringArray
var list_form_after : PackedStringArray

var label : RichTextLabel
var scrollbar : VScrollBar

func _ready():
	label = %RichTextLabel as RichTextLabel
	scrollbar = label.get_v_scroll_bar()

func move_slider(delta):
	scroll_pos = (scroll_pos + vertical_speed * delta)
	scrollbar.value = scroll_pos
	return scrollbar.max_value - scrollbar.page == scrollbar.value

func initialize_values(text : String):
	list_form_prev = form_prev.split('|')
	list_form_during = form_during.split('|')
	list_form_after = form_after.split('|')
	var padd_string = "\n".repeat(padd)
	var tmpp = (padd_string + "[fill]" + text + "[/fill]" + padd_string)
	splitted_text = tmpp.split('*')
	
	for i in range(1, splitted_text.size(), 2):
		var tmp = splitted_text[i].split('|')
		correct_words.append(tmp[1])
		splitted_text[i] = list_form_prev[0] + tmp[0] + list_form_prev[1]
		unformated_strings.append(tmp[0])
	update_text()
	return correct_words.size() == 0

func update_text():
	label.text = ''.join(splitted_text)

func manage_input(charc : String):
	if not edited:
		splitted_text[current_index * 2 + 1] = list_form_during[0] + list_form_during[1]
		unformated_strings[current_index] = ""
		edited = true
	splitted_text[current_index * 2 + 1] = splitted_text[current_index * 2 + 1].insert(len(splitted_text[current_index * 2 + 1]) - len(list_form_during[1]), charc)
	unformated_strings[current_index] += charc
	update_text()

func next_word():
	splitted_text[current_index * 2 + 1] = list_form_after[0] + unformated_strings[current_index] + list_form_after[1]
	update_text()
	current_index += 1
	edited = false
	return current_index >= correct_words.size()

func erase_current_word():
	edited = false
	splitted_text[current_index * 2 + 1] = list_form_prev[0] + unformated_strings[current_index] + list_form_prev[1]
	update_text()

func calculate_score():
	var score = 0
	for i in range(correct_words.size()):
		score += int(unformated_strings[i] == correct_words[i])
	return [score, correct_words.size()]

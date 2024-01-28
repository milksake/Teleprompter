extends Node

var main_scene := preload("res://Scenes/main.tscn")
var current_level = 0

func restart_level():
	get_tree().change_scene_to_packed(main_scene)

func next_level():
	current_level += 1
	restart_level()

func start():
	current_level = 0
	next_level()

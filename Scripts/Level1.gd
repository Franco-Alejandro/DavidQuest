extends Node2D

onready var global_singleton = get_node("/root/Global")

func _ready():
	global_singleton.goto_scene("res://Scenes/Level2.tscn")
	pass


func _on_SuperHotdog_hide():
	global_singleton.goto_scene("res://Scenes/Level2.tscn")
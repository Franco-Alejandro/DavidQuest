extends Node2D

onready var global_singleton = get_node("/root/Global")

func _ready():
	pass


func _on_SuperHotdog_hide():
	#global_singleton.goto_scene("res://Scenes/Level2.tscn")
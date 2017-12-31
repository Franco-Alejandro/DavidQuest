extends Node2D
var hotdogs_total = 0
var hotdogs_collected = -1
onready var SHotdog = get_node("SuperHotdog")
onready var global_singleton = get_node("/root/Global")

func _ready():
	SHotdog.connect("hide", self, "_on_SuperHotdog_hide" )
	pass


func _on_SuperHotdog_hide():
	global_singleton.goto_scene("res://Scenes/Level2.tscn")
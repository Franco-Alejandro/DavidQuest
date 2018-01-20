extends Node2D

onready var SHotdog = get_node("SuperHotdog")
onready var global_singleton = get_node("/root/Global")

func _ready():
	SHotdog.connect("hide", self, "_on_SuperHotdog_hide" )
	pass


func _on_SuperHotdog_hide():
	get_node("David/SuperHotdogEaten").play()
	OS.delay_msec(3000)
	global_singleton.goto_scene("res://Scenes/Level3.tscn")
extends Node2D

onready var global_singleton = get_node("/root/Global")

func _ready():
	#global_singleton.goto_scene("res://Scenes/Level3.tscn")
	pass


func _on_SuperHotdog_hide():
	get_node("David/SuperHotdogEaten").play()
	OS.delay_msec(3000)
	global_singleton.goto_scene("res://Scenes/Level2.tscn")


func _on_Deathzone_body_enter( body ):
	get_node("David").david_die()
	pass # replace with function body

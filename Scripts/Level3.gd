extends Node2D

onready var global_singleton = get_node("/root/Global")

func _ready():
	get_node("Level3Theme").play()
	pass


func _on_SuperHotdog_hide():
	get_node("David").jumping = false
	get_node("David").jump_count = 0
	pass
	
func _on_DeathArea_body_enter( body ):
	get_node("David").david_die()
	pass # replace with function body



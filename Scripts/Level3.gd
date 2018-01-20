extends Node2D

onready var global_singleton = get_node("/root/Global")
onready var david = get_node("David")
func _ready():
	get_node("Level3Theme").play()
	pass


func _on_SuperHotdog_hide():
	get_node("David/SuperHotdogEaten").play()
	david.jumping = false
	david.health += 15
	david.jump_count = 0
	david.added_jump =150 
	pass
	
func _on_DeathArea_body_enter( body ):
	david.david_die()
	pass # replace with function body



extends Node2D

export var value = 1

func _ready():
	
	if get_owner() != null:
		get_owner().hotdogs_total += value
	get_node("Area2D").connect("body_enter", self, "_collect_hotdog" )
	
	pass

func _collect_hotdog( body ):
	print("mueve el culo panchito")
	queue_free()
	pass # replace with function body

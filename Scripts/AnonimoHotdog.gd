extends Node2D
export var value = 1

func _ready():
	get_node("AnonimoHotdogAnimation").play("Anim")
	pass


func _collect_hotdog( body ):
	if get_owner() != null:
		get_owner().get_node("David").bad_hotdog_eaten += value
	queue_free()
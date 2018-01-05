extends Node2D

export var value = 1

func _ready():
	pass


func _collect_hotdog( body ):
	queue_free()
	emit_signal("hide")
	pass # replace with function body

extends Node2D

export var value = 1

func _ready():
	get_node("SuperHotdogArea2D").connect("body_enter", self, "_collect_hotdog" )
	pass


func _collect_hotdog( body ):
	queue_free()
	emit_signal("hide")
	pass # replace with function body

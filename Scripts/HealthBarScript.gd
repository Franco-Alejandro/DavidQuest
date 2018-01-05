extends Node2D
#vars
export (bool) var display_health_label = false
onready var Health_points = get_node("Health_points")
var max_hp =100
var curr_val =100

onready var health = get_node("Health")

func _ready():
	if(!display_health_label):
		Health_points.hide()
	
	pass

func init():
	update()

func set_hp(value):
	curr_val = clamp (value,0,max_hp)
	update()

func set_position(var x, var y):
	set_global_pos(Vector2(x,y))

func update():
	
	#Health %
	var percentage = curr_val/max_hp
	
	#Update hp
	health.set_scale(Vector2(percentage,1))
	
	#Update label
	var percentage_txt =""
	Health_points.set_text(percentage_txt.pad_decimals(0))
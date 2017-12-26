extends KinematicBody2D

var direction = 0
const ACCEL = 10
const DECEL = 20
const MAX_SPEED = 15
var velocity = 0
var speed = 0

func _ready():
	set_process(true)
	pass
func set_direction() :
	if Input.is_action_pressed("ui_right"):
		direction = 1
	elif Input.is_action_pressed("ui_left"):
		direction = -1
	else:
		direction = 0
	pass
	
func _process(delta):
	set_direction()
	if direction:
		speed += ACCEL * delta
	else:
		speed -= DECEL * delta
	speed = clamp (speed, 0, MAX_SPEED)
	velocity = speed + delta * direction
	
	move(Vector2(velocity, 0))
	
	pass
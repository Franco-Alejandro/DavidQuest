extends KinematicBody2D

var direction = 0
var input_direction = 0
const ACCEL = 250
const DECEL = 500
const MAX_SPEED = 150
var velocity = 0
var speed = 0

func _ready():
	set_process(true)
	pass
func set_direction():
	if input_direction:
		direction = input_direction
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
	else:
		input_direction = 0
	pass
func _process(delta):
	set_direction()
	
	if input_direction:
		speed += ACCEL * delta
	else:
		speed -= DECEL * delta
	
	speed = clamp(speed, 0, MAX_SPEED)
	velocity = speed * delta * direction
	move(Vector2(velocity, 0))
	pass
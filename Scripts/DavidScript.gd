extends KinematicBody2D

var direction = 0
var input_direction = 0
var velocity = Vector2()
var speed_x = 0
var speed_y = 0

const ACCEL = 250
const DECEL = 500
const MAX_SPEED = 150
const JUMP_FORCE = 800
const GRAVITY = 2000

func _ready():
	set_process_input(true)
	set_process(true)
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		speed_y = -JUMP_FORCE	
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
		speed_x += ACCEL * delta
	else:
		speed_x -= DECEL * delta
	
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	speed_y += GRAVITY * delta
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	move(velocity)

	pass
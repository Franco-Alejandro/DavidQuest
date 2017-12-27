extends KinematicBody2D

var direction = 0
var input_direction = 0
var velocity = Vector2()
var speed_x = 0
var speed_y = 0

#HEALTH BAR
onready var health_bar = get_node("HealthBar")

var health = 100

const ACCEL = 250
const DECEL = 500
const MAX_SPEED = 150
const JUMP_FORCE = 800
const GRAVITY = 2000

func _ready():
	set_process_input(true)
	set_process(true)
	health_bar.init()
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
		health -= 0.25
		health_bar.set_hp(health)
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		health -= 0.25
		health_bar.set_hp(health)
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
	var movement_reminder = move(velocity)
	health_bar.set_global_pos(Vector2(85,25))
	if(health<0):
		queue_free()
	if get_owner().hotdogs_collected>0:
		get_owner().hotdogs_collected = 0;
		health += 10
		health_bar.set_hp(health)
	if is_colliding():
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_reminder)
		speed_y = normal.slide(Vector2(0, speed_y)).y
		move(final_movement)
	pass

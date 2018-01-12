extends KinematicBody2D

var hotdogs_collected = -1
var bad_hotdog_eaten = 0

#HEALTH BAR
var health = 100
onready var health_bar = get_node("HealthBar")

#MOVEMENT
var jump_count = 0 
var direction = 0
var input_direction = 0
var velocity = Vector2()
var speed_x = 0
var speed_y = 0
var jumping = false

#CONST VALUES
const ACCEL = 250
const DECEL = 500
const MAX_SPEED = 150
const JUMP_FORCE = 600
const GRAVITY = 2000
const MAX_FALL_SPEED = 1400
const MAX_JUMP_COUNT = 2
const LIFE_COST_PER_STEP = 0.21

onready var global_singleton = get_node("/root/Global")
onready var spriteAnimation = get_node("AnimatedSprite")
func _ready():
	set_process_input(true)
	set_fixed_process(true)
	health_bar.init()
	pass

func _fixed_process(delta):
	set_direction(delta)
	animations()
	collisioning(move(velocity))
	update_health()
	health_bar.set_hp(health)
	health_bar.set_position(get_node( "Camera2D" ).get_camera_screen_center().x,20)
	pass

func update_health():
	if(health<0):
		get_node("DyingSFX").play("David grito")
		OS.delay_msec(2400)
		global_singleton.goto_scene("res://Scenes/"+get_tree().get_current_scene().get_name()+".tscn")
	if hotdogs_collected>0:
		hotdogs_collected = 0;
		health += 10
		get_node("EatingSFX").play("SFX OBTENCION PANCHO")
	if bad_hotdog_eaten>0:
		bad_hotdog_eaten = 0;
		health -= 10


func collisioning(var movement_reminder):
	if is_colliding():
		jumping = false
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_reminder)
		speed_y = normal.slide(Vector2(0, speed_y)).y
		move(final_movement)
		jump_count = 0
		
func animations():
	if !jumping:
		if (input_direction == 0) :
			spriteAnimation.play("idle")
		else:
			spriteAnimation.play("walk")
	else:
		spriteAnimation.play("jump")
		
		
func _input(event):
	if jump_count < MAX_JUMP_COUNT and event.is_action_pressed("ui_up"):
		speed_y = -JUMP_FORCE
		jump_count += 1
		spriteAnimation.play("jump")
		get_node("../JumpSound").play("SFX SALTO")
		jumping = true
	pass

func set_direction(delta):
	if input_direction:
		direction = input_direction
		speed_x += ACCEL * delta
		health -= LIFE_COST_PER_STEP
	else:
		speed_x -= DECEL * delta
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		spriteAnimation.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		spriteAnimation.set_flip_h(false)
	else:
		input_direction = 0
		
	speed_y += GRAVITY * delta
	speed_y = clamp(speed_y, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	pass
	
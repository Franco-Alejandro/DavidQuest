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
const JUMP_FORCE = 500
const GRAVITY = 2000
const MAX_FALL_SPEED = 1400
const MAX_JUMP_COUNT = 2
const LIFE_COST_PER_STEP = 0.15
const HEALTH_PER_HOTDOG = 10
const MAX_HEALTH = 100
const MIN_HEALTH = -1
enum {BACKWARDS = -1, NONE = 0, FORWARD=1}

onready var global_singleton = get_node("/root/Global")
onready var sprite_animation = get_node("AnimatedSprite")
onready var dying_sfx = get_node("DyingSFX")
onready var walking_sfx =  get_node("WalkingSFX")
onready var eating_sfx =  get_node("EatingSFX")
onready var jumping_sfx = get_node("JumpingSFX")


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
		david_die()
	if hotdogs_collected>0:
		hotdogs_collected = 0;
		health += HEALTH_PER_HOTDOG
		eating_sfx.play()
	if bad_hotdog_eaten>0:
		bad_hotdog_eaten = 0;
		health -= HEALTH_PER_HOTDOG
		get_node("BadHotdogSFX").play()
	health = clamp(health,MIN_HEALTH,MAX_HEALTH)
	

func collisioning(var movement_reminder):
	if is_colliding():
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_reminder)
		speed_y = normal.slide(Vector2(0, speed_y)).y		
		if move(final_movement) == Vector2(0,0):
			jumping = false
			jump_count = 0

func animations():
	if !jumping:
		if (input_direction == 0) :
			sprite_animation.play("idle")
		else:
			sprite_animation.play("walk")
			if not walking_sfx.is_playing():
				walking_sfx.play()
	else:
		sprite_animation.play("jump")
		
		
func _input(event):
	if jump_count < MAX_JUMP_COUNT and event.is_action_pressed("ui_up"):
		speed_y = -JUMP_FORCE
		jump_count += 1
		sprite_animation.play("jump")
		jumping_sfx.play()
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
		input_direction = BACKWARDS
		sprite_animation.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		input_direction = FORWARD
		sprite_animation.set_flip_h(false)
	else:
		input_direction = NONE
		
	speed_y += GRAVITY * delta
	speed_y = clamp(speed_y, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	pass
	
func david_die():
	dying_sfx.play("David grito")
	OS.delay_msec(2400)
	global_singleton.goto_scene("res://Scenes/"+get_tree().get_current_scene().get_name()+".tscn")

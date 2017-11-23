extends KinematicBody2D

const GRAVITY = 10
const FLOOR_ANGLE_TOLERANCE = 10
const speed = 690
const jump_power = 1000
const gravity_multiplier = 3

onready var ray_left = get_node("RayCastLeft")
onready var ray_right = get_node("RayCastRight")
onready var weapon = get_node("Weapon")

var velocity = Vector2()
var jump_num = 0
var max_jumps = 2
var grounded = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	ray_left.add_exception(self)
	ray_right.add_exception(self)

func _fixed_process(delta):
	# apply gravity
	velocity.y += GRAVITY * gravity_multiplier
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
	else:
		velocity.x = 0

	var motion = velocity * delta
	motion = move(motion)

	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		
		move(motion)

		if (rad2deg(acos(n.dot(Vector2(0, -1)))) < FLOOR_ANGLE_TOLERANCE):
			jump_num = 1
			grounded = true
	else:
		grounded = false
		
		
	if ray_right.is_colliding():
		print("on right wall")
	if ray_left.is_colliding():
		print("on left wall")

func jump():
	if grounded == true:
		jump_num = 0
	if jump_num < max_jumps:
		velocity.y = -jump_power
		jump_num += 1

func _input(event):
	if event.is_echo():
		return
		
	if event.is_action_pressed("jump"):
		jump()
		
	if event.is_action_pressed("shoot"):
		weapon.shoot()
		
func collected():
	print("player collected item")
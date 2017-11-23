extends RigidBody2D

export var speed = 50

func setup(dir):
	set_linear_velocity(dir.normalized() * speed)
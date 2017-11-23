extends Node2D

const bullet = preload("res://Bullet/Bullet.tscn")

var target = Vector2()

func _ready():
	set_process_input(true)
	
func shoot():
	var b = bullet.instance()
	get_tree().get_current_scene().add_child(b)
	b.set_pos(get_global_pos())
	b.setup(target - get_global_pos())

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON && event.button_index == BUTTON_LEFT) && event.pressed == true:
		shoot()
	if (event.type==InputEvent.MOUSE_MOTION):
		target = event.pos

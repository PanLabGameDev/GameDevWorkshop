extends Node2D

const bullet = preload("res://Bullet/Bullet.tscn")

func shoot():
	var b = bullet.instance()
	get_tree().get_current_scene().add_child(b)
	b.set_pos(get_global_pos())
	b.setup(Vector2(0, -1))

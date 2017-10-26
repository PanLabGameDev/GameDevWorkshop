extends Area2D

func _ready():
	connect("body_enter", self, "_on_body_enter")

func _on_body_enter(body):
	body.collected()
	queue_free()
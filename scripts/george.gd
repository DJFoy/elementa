extends CharacterBody2D

var timer:= Timer.new()
var direction: Vector2
var speed = 50
var rand:= randf()

func _ready() -> void:
	randomize()
	add_child(timer)
	timer.autostart = false
	timer.wait_time = randi_range(1, 1)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	var dir_modify:= pow(-1, randi() % 2)
	if rand > 0.6:
		direction = Vector2(0,0)
	elif rand > 0.3:
		direction = Vector2(1,0) * dir_modify
	else:
		direction = Vector2(0,1) * dir_modify

func _on_timer_timeout():
	rand = randf()
	timer.autostart = false
	timer.wait_time = randi_range(1, 1)
	timer.start()
	var dir_modify:= pow(-1, randi() % 2)
	if rand > 0.6:
		direction = Vector2(0,0)
	elif rand > 0.3:
		direction = Vector2(1,0) * dir_modify
	else:
		direction = Vector2(0,1) * dir_modify

extends State
class_name WalkLeft

@onready var npc:= owner

func Enter():
	for i in npc.get_children():
		if i.is_class("AnimatedSprite2D"):
			i.play("walk_left")

func Physics_Update(delta):
	npc.velocity = npc.direction *  npc.speed
	npc.move_and_slide()
	
	if npc.direction.x > 0:
		Transitioned.emit(self, "walkright")
	elif npc.direction.y < 0:
		Transitioned.emit(self, "walkup")
	elif npc.direction.y > 0:
		Transitioned.emit(self, "walkdown")
	elif npc.direction == Vector2(0,0):
		Transitioned.emit(self, "idle")

func Exit():
	npc.velocity = Vector2(0,0)

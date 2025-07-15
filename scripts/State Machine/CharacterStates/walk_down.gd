extends State
class_name WalkDown

@onready var npc:= owner

func Enter():
	for i in npc.get_children():
		if i.is_class("AnimatedSprite2D"):
			i.play("walk_down")

func Physics_Update(delta):
	npc.velocity = npc.direction *  npc.speed
	npc.move_and_slide()
	
	if npc.direction.x > 0:
		Transitioned.emit(self, "walkright")
	elif npc.direction.x < 0:
		Transitioned.emit(self, "walkleft")
	elif npc.direction.y < 0:
		Transitioned.emit(self, "walkup")
	elif npc.direction == Vector2(0,0):
		Transitioned.emit(self, "idle")

func Exit():
	npc.velocity = Vector2(0,0)

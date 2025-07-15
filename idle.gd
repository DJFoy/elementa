extends State
class_name Idle

@onready var npc:= owner

func Enter():
	print("George in Idle")
	for i in npc.get_children():
		if i.is_class("AnimatedSprite2D"):
			i.frame = 0
			i.pause()

func Exit():
	print("George leaving Idle")

func Physics_Update(delta):
	npc.velocity = npc.direction.normalized() * npc.speed
	npc.move_and_slide()

	
	if npc.direction.x < 0:
		Transitioned.emit(self, "walkleft")
	elif npc.direction.x > 0:
		Transitioned.emit(self, "walkright")
	elif npc.direction.y > 0:
		Transitioned.emit(self, "walkdown")
	elif npc.direction.y < 0:
		Transitioned.emit(self, "walkup")

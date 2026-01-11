extends Location

@onready var dad: Non_Player_Character = $NPCs/Dad
@onready var dad_sprite := preload("res://resources/character_sprite_tilesets/dad_sprite.tres")



func _ready() -> void:
	dad.get_node("Sprite2D").texture = dad_sprite
	super()
	dialogues = {
		dad: [
			["Dad", "Morning, " + pc.player_data.name + ". How are you feeling?"],
			["Dad", "Are you ready for your first day of work?"],
			[pc.player_data.name, "..."],
			["Dad", "Hey, I know you had your heart set on that scholarship. Working as a servant in the manor won't be all that bad, though. At least you won't have to work in the mines like I did."],
			["Option", ["Right... I get to watch people like Gigi and George become adventurers while I sit at home and dust their silverware", "Yeah. I guess it could be worse"]],
			["Dad", "I'm sorry " + pc.player_data.name + ". I know it's unfair that nobles are often the only ones that get to become adventurers. I would give you the money if we had it. But, I mean, we can't even afford a Familiar for the house..."]
		]
	}

extends Character
class_name Non_Player_Character

@onready var main_sprite: Sprite2D = $MainSprite
@onready var accessory: Sprite2D = $Accessory
@onready var player_data := ResourceLoader.load("res://saves/player_data.tres")

@onready var skin_colour: Sprite2D = $NPCExtras/SkinColour
@onready var outline: Sprite2D = $NPCExtras/Outline
@onready var hair: Sprite2D = $NPCExtras/Hair
@onready var hair_shadow: Sprite2D = $NPCExtras/HairShadow
@onready var facial_hair: Sprite2D = $NPCExtras/FacialHair
@onready var eye_colour: Sprite2D = $NPCExtras/EyeColour
@onready var top: Sprite2D = $NPCExtras/Top
@onready var bottoms: Sprite2D = $NPCExtras/Bottoms

@export var npc_resource: NPC_Resource

# Add in a variable to define whether the NPC should be following another target
# A string should be passed from the NPC resource that the actor manager can resolve
@export var follow_target: String
var target: Character
@onready var state_machine: StateMachine = $StateMachine

signal follow_request
signal idle_request

func _ready() -> void:
	actor_id = npc_resource.npc_name
	super()
	add_to_group("Dialogue")
	main_sprite.texture = npc_resource.get_sprite_texture(player_data.skin_colour)
	skin_colour.texture = npc_resource.skin_tone
	hair.texture = npc_resource.npc_hair
	hair.modulate = npc_resource.hair_colour
	hair_shadow.texture = npc_resource.hair_shadow
	facial_hair.texture = npc_resource.npc_facial_hair
	facial_hair.modulate = npc_resource.hair_colour
	outline.texture = npc_resource.npc_outline
	eye_colour.texture = npc_resource.npc_eye
	eye_colour.modulate = npc_resource.eye_colour
	top.texture = npc_resource.npc_top
	bottoms.texture = npc_resource.npc_bottom
	
	EventBus.register_followers.connect(_initialise_following)

func _initialise_following() -> void:
	follow_target = npc_resource.follow_target
	
	print("This NPC is primed to follow %s" % follow_target)
	
	if follow_target:
		print("And now it should be set up that it is tied to the right node, %s" % ActorManager.get_actor(follow_target))
		target = ActorManager.get_actor(follow_target)
		print("See, look: %s" % target)


func follow() -> void:
	follow_request.emit()

func idle() -> void:
	idle_request.emit()

func _continuous_movement():
	if GameState.is_locked():
		_stop_movement()
		return
	if target.move_ray.is_colliding():
		_stop_movement()
		return
	if current_dir != wants_to_move_dir:
		direction_change(wants_to_move_dir)
	force_move(wants_to_move_dir)

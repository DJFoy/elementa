extends Node2D
class_name CutsceneHelper

static func move(location: Location, actor_id: String, destination: Vector2, wait_to_finish:= true) -> CutsceneStep:
	var s = MoveStep.new()
	s.location = location
	s.actor_id = actor_id
	s.destination = destination
	s.wait_to_finish = wait_to_finish
	return s

static func turn(actor_id: String, direction: Vector2) -> CutsceneStep:
	var s = TurnStep.new()
	s.actor_id = actor_id
	s.direction = direction
	return s

static func say(dialogue_id: String) -> CutsceneStep:
	var s = DialogueStep.new()
	s.dialogue_id = dialogue_id
	return s

static func transition(transition_type: TransitionStep.TransitionType, duration:= 0.3) -> CutsceneStep:
	var s = TransitionStep.new()
	s.transition = transition_type
	s.duration = duration
	return s

static func animation(actor_id: String, anim_id: String) -> CutsceneStep:
	var s = AnimationStep.new()
	s.actor_id = actor_id
	s.anim_id = anim_id
	return s

static func spawn(scene: PackedScene, actor_id: String, spawn_position: Vector2, parent: Node, setup: Dictionary) -> SpawnStep:
	var s = SpawnStep.new()
	s.scene = scene
	s.actor_id = actor_id
	s.position = spawn_position
	s.parent = parent
	s.setup = setup
	return s

static func wait(duration: float) -> WaitStep:
	var s = WaitStep.new()
	s.duration = duration
	return s

static func change_tilemap(tilemap: TileMapLayer, target_tile: Vector2i, new_tile: Vector2i, trans: ChangeTileMapStep.Transform) -> ChangeTileMapStep:
	var s = ChangeTileMapStep.new()
	s.tilemap = tilemap
	s.cell = target_tile
	s.new_tile = new_tile
	s.transform = trans
	return s
	
static func despawn(actor_id: String) -> DespawnStep:
	var s = DespawnStep.new()
	s.actor_id = actor_id
	return s

static func emote(actor_ids: Array[String], emote_resource: EmoteResource) -> EmoteStep:
	var s = EmoteStep.new()
	s.actor_ids = actor_ids
	s.emote = emote_resource
	return s

extends Node2D
class_name CutsceneHelper

static func move(actor: Character, direction: Vector2, wait_to_finish:= true) -> CutsceneStep:
	var s = MoveStep.new()
	s.actor = actor
	s.direction = direction
	s.wait_to_finish = wait_to_finish
	return s

static func turn(actor: Character, direction: Vector2) -> CutsceneStep:
	var s = TurnStep.new()
	s.actor = actor
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

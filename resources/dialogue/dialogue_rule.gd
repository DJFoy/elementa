extends Resource
class_name Dialogue_Rule

@export var dialogue_id: String
@export var requirements: Array[String]

func condition_met(global_state: Dictionary) -> bool:
	for flag in requirements:
		if not global_state.get(flag, false):
			return false
	return true

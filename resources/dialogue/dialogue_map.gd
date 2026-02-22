extends Resource
class_name DialogueMap

@export var rules: Array[DialogueRule]

func resolve_dialogue() -> String:
	print("Attempting to resolve dialogue")
	for rule in rules:
		if rule.condition_met():
			print("dialogue id resolved: " + str(rule.dialogue_id))
			return rule.dialogue_id
	
	print("Could not resolve dialogue_id!")
	return ""

extends Resource
class_name DialogueRule

@export var dialogue_id: String
@export var required_chapter: String = ""
@export var one_time_dialogue: Array[String] = []
@export var items_collected: Array[String] = []
@export var significant_events: Array[String] = []
@export var check_criteria: Array[Dictionary] = []
@export var random_chance: float

func condition_met() -> bool:
	# Is chapter greater than when this can appear?
	if required_chapter != "":
		if Global_World_State.chapter != required_chapter:
			return false
	
	# Any dialogue in list must not have been said before
	for dialogue_id in one_time_dialogue:
		if Global_World_State.one_time_dialogues.has(dialogue_id):
			return false
	
	# All items required must have been gathered
	# First create a variable to store the number of matching items collected
	var items_gathered: int = 0
	for item in items_collected:
		if Global_World_State.items_collected.has(item):
			items_gathered += 1
	
	# Then check that if the number of items gathered is less than the number of required items, return false
	if items_gathered < items_collected.size() && items_collected.size() > 0:
		return false
	
	for event in significant_events:
		if Global_World_State.significant_events.has(event):
			return false
	
	for criteria in check_criteria:
		# This checks whether a particular value in the Global state is equal to a condition, and will not play dialogue if true
		# This is different to significant_events that checks if a specific event has occured in a list
		var key = criteria["key"]
		var check = criteria["check"]
		
		for prop in Global_World_State.get_property_list():
			if prop.name == key:
				if Global_World_State.get(key) == check:
					# If the property exists, and the value matches the check, do not run dialogue
					return false
	
	if random_chance > randf():
		return false
	
	# Otherwise, return true
	return true

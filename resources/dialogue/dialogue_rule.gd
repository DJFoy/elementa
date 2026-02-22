extends Resource
class_name DialogueRule

@export var dialogue_id: String
@export var required_chapter: String = ""
@export var one_time_dialogue: Array[String] = []
@export var items_collected: Array[String] = []

func condition_met() -> bool:
	print("Checking conditions")
	# Is chapter greater than when this can appear?
	print(required_chapter)
	if required_chapter != "":
		if Global_World_State.chapter < required_chapter:
			return false
	
	# Any dialogue in list must not have been said before
	print(one_time_dialogue)
	for dialogue_id in one_time_dialogue:
		if Global_World_State.one_time_dialogues.has(dialogue_id):
			return false
	
	# All items required must have been gathered
	# First create a variable to store the number of matching items collected
	print(items_collected)
	var items_gathered: int = 0
	for item in items_collected:
		if Global_World_State.items_collected.has(item):
			items_gathered += 1
	
	# Then check that if the number of items gathered is less than the number of required items, return false
	if items_gathered < items_collected.size() && items_collected.size() > 0:
		return false
	
	# Otherwise, return true
	return true

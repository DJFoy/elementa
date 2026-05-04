extends Resource
class_name NPC_Registry

# Blackberry Village NPCs
const DAD = preload("uid://c3n6c7qnrumv3")
const PROF_OLIVIA = preload("uid://b03hbee147rla")


static func get_npc(npc_id: String) -> NPC_Resource:
	match npc_id:
		"Dad": return DAD
		"Prof_Olivia": return PROF_OLIVIA
	print("Cannot resolve npc with id: ", npc_id)
	return null

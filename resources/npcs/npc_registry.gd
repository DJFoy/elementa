extends Resource
class_name NPC_Registry

# Blackberry Village NPCs
static var dad = preload("uid://c3n6c7qnrumv3")
static var prof_olivia = preload("uid://b03hbee147rla")

static var npc_bbv_1 = preload("uid://cqp5t363nac8h")
static var npc_bbv_2 = preload("uid://dnagkkg67x5hl")


static func get_npc(npc_id: String) -> NPC_Resource:
	match npc_id:
		"Dad": return dad
		"Prof_Olivia": return prof_olivia
		"NPC_BBV_1": return npc_bbv_1
		"NPC_BBV_2": return npc_bbv_2
	print("Cannot resolve npc with id: ", npc_id)
	return null

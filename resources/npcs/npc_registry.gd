extends Resource
class_name NPC_Registry

# Blackberry Village NPCs
static var dad = preload("uid://c3n6c7qnrumv3")
static var prof_olivia = preload("uid://b03hbee147rla")
static var butler = preload("uid://c6de045gnpr0g")

static var npc_bbv_1 = preload("uid://cqp5t363nac8h")
static var npc_bbv_2 = preload("uid://dnagkkg67x5hl")
static var npc_bbv_3 = preload("uid://6ap18qwmf0i")
static var npc_bbv_4 = preload("uid://cpinvovik5so0")
static var npc_bbv_5 = preload("uid://cp2wlwwsug1q4")
static var npc_bbv_6 = preload("uid://utla6sb6psai")
static var npc_bbv_7 = preload("uid://bn8jmxbx47xpw")
static var npc_bbv_8 = preload("uid://dij413267nlco")

# Starter Familiars

static var frostling = preload("uid://cllovtxx7mt6q")
static var grisnir = preload("uid://dx2rd4pit7gtj")
static var tsarin = preload("uid://dn3nm7ifpul7r")

static func get_npc(npc_id: String) -> NPC_Resource:
	match npc_id:
		"Dad": return dad
		"Prof_Olivia": return prof_olivia
		"Butler": return butler
		"NPC_BBV_1": return npc_bbv_1
		"NPC_BBV_2": return npc_bbv_2
		"NPC_BBV_3": return npc_bbv_3
		"NPC_BBV_4": return npc_bbv_4
		"NPC_BBV_5": return npc_bbv_5
		"NPC_BBV_6": return npc_bbv_6
		"NPC_BBV_7": return npc_bbv_7
		"NPC_BBV_8": return npc_bbv_8
		"Frostling": return frostling
		"Grisnir": return grisnir
		"Tsarin": return tsarin
	print("Cannot resolve npc with id: ", npc_id)
	return null

extends Save
class_name WorldStateSave

# ---------------- LOADING ----------------

static func load(slot: String = "") -> WorldStateSave:
	return Save._load_impl("world_state", false, WorldStateSave, slot) as WorldStateSave

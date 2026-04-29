## burger_save.gd :: example save file
class_name BurgerSave extends Save

# ---------------- LOADING ----------------

static func load(slot: String = "") -> BurgerSave:
	return Save._load_impl("burger", false, BurgerSave, slot) as BurgerSave

# --------------- SAVE DATA ---------------

@export var buns: int = 0
@export var patties: int = 0
@export var cheese_slices: int = 0
@export var sauce_ml: float = 0.0

@export var toppings: Dictionary[String, bool] = {
	"lettuce": false,
	"tomato": false,
	"onion": false,
	"pickle": false,
}

# ---------------- HELPERS ----------------

func get_max_burgers() -> int:
	# Each burger needs 2 buns, 1 patty, 1 cheese, and 25ml sauce
	return mini(mini(int(buns / 2.0), patties), mini(cheese_slices, int(sauce_ml / 25.0)))

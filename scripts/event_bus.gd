extends Node

# Set up global scene change signal
signal world_change_request

# Register an "Actor" with the cutscene manager on instantiating a scene
signal register_actor(actor_id: String, actor: Node)

signal register_followers()

signal cutscene_finished

signal dialogue_finished

# Request to open a window in a cutscene
signal open_window

# Finsh a movement request
signal movement_complete

# Signal player requested the game menu open
signal open_game_menu


# When the Familiar is Chosen or Changed
signal familiar_changed(name: String)

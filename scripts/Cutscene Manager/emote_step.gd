extends CutsceneStep
class_name EmoteStep

var actor_ids: Array[String]
@export var emote: EmoteResource

func run(director: CutsceneManager) -> void:
	var signals: Array
	var signal_group = SignalGroup.new()
	for actor_id in actor_ids:
		var actor = ActorManager.get_actor(actor_id)
		signals.append(actor.emote_finished)
		
		actor.trigger_emote(emote)
	
	await signal_group.all(signals)

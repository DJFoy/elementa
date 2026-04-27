extends Node2D
class_name AnimatedCutscene

@export var window: Marker2D
@export var counter: Marker2D
@export var peek: Marker2D
@export var leave: Marker2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func play_animation(anim_id: String):
	match anim_id:
		"bird_peek":
			global_position = peek.global_position + Vector2(0,5)
			visible = true
	
			var peeking = create_tween()
			peeking.tween_property(self, "global_position", peek.global_position, 5)
			await peeking.finished
	
			sprite_2d.play("flying_scroll")
	
			var tween = create_tween()
			tween.tween_property(self, "global_position", window.global_position, 0.3)
			await tween.finished
			
			z_index = 0
			EventBus.open_window.emit()
			sprite_2d.play("stationary_scroll")
			
		"bird_enter":
			sprite_2d.play("flying_scroll")
			var tween2 = create_tween()
			tween2.tween_property(self, "global_position", counter.global_position, 0.9)
			await tween2.finished
	
			sprite_2d.play("stationary_scroll")
	
			await get_tree().create_timer(1).timeout
		"bird_drop":
			sprite_2d.play("stationary_no_scroll")
		"bird_leave":
			sprite_2d.flip_h = true
			
			sprite_2d.play("flying_no_scroll")
			var leaving = create_tween()
			leaving.tween_property(self, "global_position", window.global_position, 0.9)
			await leaving.finished
			
			z_index = -1
			
			var leaving_faster = create_tween()
			leaving_faster.tween_property(self, "global_position", leave.global_position, 0.7)
			await leaving_faster.finished
			
			visible = false

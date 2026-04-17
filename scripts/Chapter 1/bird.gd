extends Node2D
class_name AnimatedCutscene

@export var window: Marker2D
@export var counter: Marker2D
@export var peek: Marker2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

signal open_window

func play_animation(anim_id: String):
	match anim_id:
		"bird_enter":
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
			open_window.emit()
	
			sprite_2d.play("stationary_scroll")	
			await get_tree().create_timer(1.5).timeout
	
			sprite_2d.play("flying_scroll")
			var tween2 = create_tween()
			tween2.tween_property(self, "global_position", counter.global_position, 0.9)
			await tween2.finished
	
			sprite_2d.play("stationary_scroll")
	
			await get_tree().create_timer(1).timeout
		"bird_drop":
			sprite_2d.play("stationary_no_scroll")

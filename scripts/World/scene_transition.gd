extends Node2D

const FADE_IN = "fade_in"
const FADE_OUT = "fade_out"
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func play_trans(transition: String):
	if transition == FADE_OUT:
		Global.lock()
		await get_tree().create_timer(0.5).timeout
		await fade_out()
	if transition == FADE_IN:
		await fade_in()
		Global.unlock()


func fade_in(duration:= 0.3):
	print("Fading in!")
	var tween = create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,0), duration)
	print(color_rect.color)
	await tween.finished
	print(color_rect.color)
	print("Complete")

func fade_out(duration:= 0.3):
	print("Fading out :(!")
	var tween = create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,1), duration)
	await tween.finished

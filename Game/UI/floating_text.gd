#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node2D


const TWEEN_DURATION := 0.3
const TWEEN_DURATION_2 := 0.4
const SCALE_TWEEN_DURATION := 0.15


func _ready() -> void:
	pass
	

func start(text: String) -> void:
	$Label.text = text
	var tween = create_tween()
	tween.parallel()
	
	tween.tween_property(self, "global_position", global_position + Vector2.UP * 16, TWEEN_DURATION)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	
	tween.tween_property(self, "global_position", global_position + Vector2.UP * 32, TWEEN_DURATION_2)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "scale", Vector2.ZERO, TWEEN_DURATION_2)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	
	tween.tween_callback(queue_free)

	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, SCALE_TWEEN_DURATION)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, SCALE_TWEEN_DURATION)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

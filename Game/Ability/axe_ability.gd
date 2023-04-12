#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node2D
class_name AxeAbility

@onready var hitbox_component: Area2D = $HitBoxComponent

const MIN_REVOLUTIONS = 0.0
const MAX_REVOLUTIONS = 2.0
const TWEEN_DURATION = 3.5
const MAX_RADIUS = 100.0

var base_rotation = Vector2.RIGHT


func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var tween = create_tween()
	tween.tween_method(tween_method, MIN_REVOLUTIONS, MAX_REVOLUTIONS, TWEEN_DURATION)
	tween.tween_callback(queue_free)
	

func tween_method(rotations: float) -> void:
	var current_radius = (rotations / 2) * MAX_RADIUS
	var current_dir = base_rotation.rotated(rotations * TAU)
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	global_position = player.global_position + (current_dir * current_radius)

#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node2D

@export var experience_value: float = 1

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

const START_PERCENT: float = 0.0
const END_PERCENT: float = 1.0
const DURATION: float = 0.5


func tween_collect(percent: float, start_pos: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	global_position = start_pos.lerp(player.global_position, percent)
	var dir_from_start = player.global_position - start_pos
	
	var target_rotation = dir_from_start.angle() + deg_to_rad(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-4 * get_process_delta_time()))
	

func collect() -> void:
	GameEvents.emit_experience_vial_collected(experience_value)
	queue_free()


func disable_collision() -> void:
	collision_shape_2d.disabled = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	Callable(disable_collision).call_deferred()
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), START_PERCENT, END_PERCENT, DURATION)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.05).set_delay(0.45)
	tween.chain()
	tween.tween_callback(collect)
	$RandomAudioPlayerComponent.play_random()

#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name BasicEnemy

const MAX_SPEED = 75

func _physics_process(_delta: float) -> void:
	var dir = get_direction_to_player()
	velocity = dir * MAX_SPEED
	move_and_slide()

func get_direction_to_player() -> Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Player
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

func _on_area_2d_area_entered(_area: Area2D) -> void:
	queue_free()

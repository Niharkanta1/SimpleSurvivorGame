#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

const SPAWN_RADIUS = 370

@export var basic_enemy_scene: PackedScene


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var rand_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spwan_position = player.global_position + (rand_dir * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as BasicEnemy
	get_parent().add_child(enemy)
	enemy.global_position = spwan_position

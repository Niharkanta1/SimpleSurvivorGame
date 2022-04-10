#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name EnemySpawnManager

const SPAWN_RADIUS = 370

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

@onready var timer: Timer = $Timer

var base_spawn_time

func _ready() -> void:
	arena_time_manager.arena_difficulty_increased.connect(_on_arena_difficulty_increased)
	base_spawn_time = timer.wait_time


func _on_timer_timeout() -> void:
	timer.start()
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var rand_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spwan_position = player.global_position + (rand_dir * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as BasicEnemy
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spwan_position


func _on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off

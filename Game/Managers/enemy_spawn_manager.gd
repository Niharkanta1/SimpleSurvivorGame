#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name EnemySpawnManager

const SPAWN_RADIUS = 370

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

@onready var timer: Timer = $Timer

var enemy_table = WeightedTable.new()
var base_spawn_time

func _ready() -> void:
	enemy_table.add_item(basic_enemy_scene, 10)
	arena_time_manager.arena_difficulty_increased.connect(_on_arena_difficulty_increased)
	base_spawn_time = timer.wait_time


func get_spawn_position() -> Vector2:
	var spwan_position = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return Vector2.ZERO
	var rand_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spwan_position = player.global_position + (rand_dir * SPAWN_RADIUS)
		var query_param = PhysicsRayQueryParameters2D.create(player.global_position, spwan_position, 1 << 2)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_param)
		if result.is_empty():
			break
		else:
			rand_dir = rand_dir.rotated(deg_to_rad(90))
	return spwan_position


func _on_timer_timeout() -> void:
	timer.start()
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate()
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


func _on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
	

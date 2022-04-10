#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

@export var sword_ability: PackedScene
@export var sword_damage: float = 5
@export var max_range: float = 100

@onready var timer: Timer = $Timer

var base_wait_time: float

func _ready() -> void:
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	base_wait_time = $Timer.wait_time


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
		
	enemies = enemies.filter(
			func(enemy: Node2D): 
			return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	enemies.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_distance = a.global_position.distance_squared_to(player.global_position)
			var b_distance = b.global_position.distance_squared_to(player.global_position)
			return a_distance < b_distance
	)
	if enemies.size() == 0:
		return
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = sword_damage
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_dir = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_dir.angle()


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id != "sword_rate":
		return
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * 0.1
	timer.wait_time = base_wait_time * (1 - percent_reduction)
	timer.start()

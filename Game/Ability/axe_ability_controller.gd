#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

@export var axe_ability_scene: PackedScene
@onready var timer: Timer = $Timer

var base_axe_damage = 10
var additional_damage_percent = 1 


func _ready() -> void:
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		return
	var axe_instance = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = base_axe_damage * additional_damage_percent


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id == "axe_damage":
		additional_damage_percent += 1 + current_upgrades["axe_damage"]["quantity"] * 0.15

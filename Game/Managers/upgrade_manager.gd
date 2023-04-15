#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name UpgradeManager

@export var experience_manager: ExperienceManager
@export var upgrade_screen: PackedScene

var upgrade_axe = preload("res://Game/Upgrades/axe.tres")
var upgrade_axe_damge = preload("res://Game/Upgrades/axe_damage.tres")
var upgrade_sword_rate = preload("res://Game/Upgrades/sword_rate.tres")
var upgrade_sword_damage = preload("res://Game/Upgrades/sword_damage.tres")
var upgrade_move_speed = preload("res://Game/Upgrades/move_speed.tres")

var upgrade_pool := WeightedTable.new()
var current_upgrades = {}


func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_move_speed, 5)
	

func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	if not has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade) -> void:
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damge, 10)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []
	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.pick_item() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
	return chosen_upgrades
	

func _on_level_up(new_level: int) -> void:
	var upgrade_screen_instance = upgrade_screen.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrade(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)

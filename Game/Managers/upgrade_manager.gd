#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name UpgradeManager

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_screen: PackedScene

var current_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)
	

func _on_level_up(new_level: int) -> void:
	var chosen_upgrade = upgrade_pool.pick_random()
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrade([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(_on_upgrade_selected)
	
	
func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade = current_upgrades.has(upgrade.id)
	if not has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)

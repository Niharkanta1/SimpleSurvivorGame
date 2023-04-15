#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

signal experience_vial_collected(value: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged


func emit_experience_vial_collected(value: float) -> void:
	experience_vial_collected.emit(value)

func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	ability_upgrade_added.emit(upgrade, current_upgrades)

func emit_player_damaged() -> void:
	player_damaged.emit()

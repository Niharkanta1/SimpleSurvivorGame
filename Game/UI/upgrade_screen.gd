#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer
class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = $%CardContainer

func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrade(upgrades: Array[AbilityUpgrade]) -> void:
	var delay = 0
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in()
		card_instance.selected.connect(_on_upgrade_selected.bind(upgrade))
		delay += 0.2
		

func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	queue_free()

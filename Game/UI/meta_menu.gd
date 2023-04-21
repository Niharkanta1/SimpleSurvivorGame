#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer
@onready var back_button: Button = %BackButton

var meta_upgrade_card = preload("res://Game/UI/meta_upgrade_card.tscn")


func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	for child in grid_container.get_children():
		child.queue_free()
	for upgrade in upgrades:
		var meta_upgrade_card_instance := meta_upgrade_card.instantiate() as MetaUpgradeCard
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)


func _on_back_pressed() -> void:
	ScreenTransition.transition_to_scene("res://Game/UI/main_menu.tscn")

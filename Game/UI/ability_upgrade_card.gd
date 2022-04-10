#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends PanelContainer
class_name AbilityUpgradeCard

signal selected

@onready var name_label: Label = $%LabelName
@onready var description_label: Label = $%LabelDescription


func _ready() -> void:
	gui_input.connect(_on_gui_input)


func set_ability_upgrade(upgrade: AbilityUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		selected.emit()

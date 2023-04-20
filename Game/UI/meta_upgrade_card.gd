#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends PanelContainer
class_name MetaUpgradeCard

@onready var name_label: Label = $%LabelName
@onready var description_label: Label = $%LabelDescription


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	

func select_card() -> void:
	$AnimationPlayer.play("selected")


func set_meta_upgrade(upgrade: AbilityUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		select_card()

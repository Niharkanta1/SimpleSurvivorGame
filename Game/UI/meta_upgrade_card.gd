#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends PanelContainer
class_name MetaUpgradeCard

@onready var name_label: Label = %LabelName
@onready var description_label: Label = %LabelDescription
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel
@onready var count_label: Label = %CountLabel

var upgrade: MetaUpgrade


func _ready() -> void:
	purchase_button.pressed.connect(_on_purchase_pressed)


func select_card() -> void:
	$AnimationPlayer.play("selected")


func update_progress() -> void:
	var curreny = MetaProgression.save_data["meta_upgrade_currency"]
	var current_quantity = 0
	if MetaProgression.save_data["meta_upgrades"].has(upgrade.id):
		current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
	var percent = curreny / upgrade.experience_cost
	var is_maxed = current_quantity >= upgrade.max_quantity
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1 or is_maxed
	if is_maxed:
		purchase_button.text = "Maxed"
	progress_label.text = str(curreny) + "/" + str(upgrade.experience_cost)
	count_label.text = "x%d" % current_quantity


func set_meta_upgrade(meta_upgrade: MetaUpgrade) -> void:
	self.upgrade = meta_upgrade
	name_label.text = meta_upgrade.title
	description_label.text = meta_upgrade.description
	update_progress()


func _on_purchase_pressed() -> void:
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")

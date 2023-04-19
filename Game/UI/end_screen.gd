#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer
class_name EndScreen

@onready var panel_container: PanelContainer = %PanelContainer


func _ready() -> void:
	$%RestartButton.pressed.connect(_on_restart_button_pressed)
	$%QuitButton.pressed.connect(_on_quit_button_pressed)
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	get_tree().paused = true


func set_defeat() -> void:
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You Lost!"
	play_jingle(true)


func set_victory() -> void:
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = "You Won!"
	play_jingle(false)


func transition_effect() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway


func play_jingle(defeat: bool) -> void:
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()


func _on_restart_button_pressed() -> void:
	transition_effect()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

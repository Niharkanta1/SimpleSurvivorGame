#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true

func set_defeat() -> void:
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You Lost!"
	
func set_victory() -> void:
	$%TitleLabel.text = "Victory"
	$%DescriptionLabel.text = "You Won!"

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

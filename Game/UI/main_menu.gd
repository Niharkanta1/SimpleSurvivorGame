#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer

var options_scene = preload("res://Game/UI/option_menu.tscn")


func _ready() -> void:
	$%PlayButton.pressed.connect(_on_play_pressed)
	$%OptionsButton.pressed.connect(_on_options_pressed)
	$%QuitButton.pressed.connect(_on_quit_pressed)
	

func transition_effect() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	

func _on_play_pressed() -> void:
	transition_effect()
	get_tree().change_scene_to_file("res://Game/main.tscn")
	

func _on_options_pressed() -> void:
	transition_effect()
	var options_scene_instance = options_scene.instantiate()
	add_child(options_scene_instance)
	options_scene_instance.back_pressed.connect(_on_options_back_pressed.bind(options_scene_instance))
	

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_back_pressed(instance: Node) -> void:
	instance.queue_free()

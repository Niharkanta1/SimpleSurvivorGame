#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer

@onready var panel_container: PanelContainer = $MarginContainer/PanelContainer

var options_scene = preload("res://Game/UI/option_menu.tscn")
var is_closing := false


func _ready() -> void:
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2
	
	%ResumeButton.pressed.connect(_on_resume_button_pressed)
	%OptionsButton.pressed.connect(_on_options_button_pressed)
	%QuitButton.pressed.connect(_on_quit_button_pressed)
	
	$AnimationPlayer.play("default")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		close()
		get_tree().root.set_input_as_handled()


func close() -> void:
	if is_closing:
		return
	is_closing = true
	$AnimationPlayer.play_backwards("default")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	await tween.finished
	get_tree().paused = false
	queue_free()


func transition_effect() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	

func _on_resume_button_pressed() -> void:
	close()
	
	
func _on_options_button_pressed() -> void:
	transition_effect()
	var options_scene_instance = options_scene.instantiate()
	add_child(options_scene_instance)
	options_scene_instance.back_pressed.connect(_on_options_back_pressed.bind(options_scene_instance))
	

func _on_options_back_pressed(instance: Node) -> void:
	instance.queue_free()

	
func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game/UI/main_menu.tscn")

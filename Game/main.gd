#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

@export var end_screen_scene: PackedScene

var pause_menu_scene = preload("res://Game/UI/pause_menu.tscn")


func _ready() -> void:
	(%Player as Player).health_component.died.connect(_on_player_died)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()


func _on_player_died() -> void:
	var screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(screen_instance)
	screen_instance.set_defeat()
	print("Player Died")
	MetaProgression.save()

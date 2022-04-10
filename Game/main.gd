#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

@export var end_screen_scene: PackedScene


func _ready() -> void:
	($%Player as Player).health_component.died.connect(_on_player_died)


func _on_player_died() -> void:
	var screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(screen_instance)
	screen_instance.set_defeat()

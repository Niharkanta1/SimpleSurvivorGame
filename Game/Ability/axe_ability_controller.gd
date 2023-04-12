#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

@export var axe_ability_scene: PackedScene
@onready var timer: Timer = $Timer

var damage = 10


func _ready() -> void:
	pass
	

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if foreground_layer == null:
		return
	var axe_instance = axe_ability_scene.instantiate() as AxeAbility
	foreground_layer.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = damage

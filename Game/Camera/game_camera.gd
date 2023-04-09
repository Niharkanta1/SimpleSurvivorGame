#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Camera2D


var target_postion := Vector2.ZERO

func _ready() -> void:
	make_current()

func _process(delta: float) -> void:
	acquire_target()
	global_position = global_position.lerp(target_postion, 1.0 - exp(-delta * 20))

func acquire_target() -> void:
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Player
		target_postion = player.global_position


#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name VelocityComponent

@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity := Vector2.ZERO


func accelerate_to_player() -> void:
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	var direction = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)


func accelerate_in_direction(direction: Vector2) -> void:
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_physics_process_delta_time()))
	

func move(character: CharacterBody2D) -> void:
	character.velocity = velocity
	character.move_and_slide()
	velocity = character.velocity


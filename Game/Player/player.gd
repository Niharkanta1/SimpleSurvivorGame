#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name Player

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var move_vector = get_movement_vector()
	var dir = move_vector.normalized()
	var target_velocity = dir * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")


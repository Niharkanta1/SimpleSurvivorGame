#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node2D

@export var health_component: HealthComponent
@export var sprite: Sprite2D


func _ready() -> void:
	health_component.died.connect(_on_die)
	$GPUParticles2D.texture = sprite.texture


func _on_die() -> void:
	if owner == null or not owner is Node2D:
		return
	var spawn_pos = (owner as Node2D).global_position
	var entities = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	global_position = spawn_pos
	$AnimationPlayer.play("default")

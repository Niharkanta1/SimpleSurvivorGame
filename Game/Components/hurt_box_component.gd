#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Area2D
class_name HurtBoxComponent

signal hit

@export var health_component: HealthComponent

var floating_text_scene = preload("res://Game/UI/floating_text.tscn")


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area is HitBoxComponent:
		return
	if health_component == null:
		return
		
	var hitbox = area as HitBoxComponent
	health_component.damage(hitbox.damage)
	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	floating_text.global_position = global_position
	if round(hitbox.damage) != hitbox.damage:
		floating_text.start("%0.1f" % hitbox.damage)
	else:
		floating_text.start(str(hitbox.damage))
	hit.emit()

#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not area is HitBoxComponent:
		return
	if health_component == null:
		return
		
	var hitbox = area as HitBoxComponent
	health_component.damage(hitbox.damage)

#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node

const TWEEN_DURATION = 0.25

@export var health_component: HealthComponent
@export var sprite: Sprite2D
@export var hit_flash_material = ShaderMaterial

var hit_flash_tween: Tween


func _ready() -> void:
	health_component.health_changed.connect(_on_health_changed)
	sprite.material = hit_flash_material
	

func _on_health_changed() -> void:
	if hit_flash_tween != null and hit_flash_tween.is_valid():
		hit_flash_tween.kill()
		
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, TWEEN_DURATION)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	

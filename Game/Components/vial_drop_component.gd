#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name VialDropCompoenent

@export var vial_scene: PackedScene
@export var health_component: HealthComponent
@export_range(0, 1) var drop_chance: float = 0.5


func _ready() -> void:
	health_component.died.connect(_on_died)


func _on_died() -> void:
	var adjusted_drop_percent = drop_chance
	var experience_gain_upgrade_count = MetaProgression.get_meta_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += 0.1
	if randf() > drop_chance:
		return
	if vial_scene == null:
		return
	if not owner is Node2D:
		return
	var spawn_pos = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_pos

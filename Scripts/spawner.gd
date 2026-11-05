extends Node2D


@export var enemy: PackedScene
@onready var path = %PathFollow2D

func _on_spawn_timer_timeout() -> void:
	var enemy_spawn = enemy.instantiate()
	path.progress_ratio = randf()
	enemy_spawn.global_position = path.global_position
	
	enemy_spawn.main_tower = get_parent()
	get_tree().current_scene.add_child(enemy_spawn)

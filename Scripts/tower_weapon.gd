extends Node2D


@export var bullet: PackedScene
@onready var area_range = $Range


func _on_cooldown_timeout() -> void:
	var enemies_in_range = area_range.get_overlapping_bodies()
	
	if enemies_in_range.size() == 0:
		return
		
	
	var target_enemy = null
	var shortest_distance = INF
	
	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		
		if distance < shortest_distance:
			shortest_distance = distance
			target_enemy = enemy
			
	if target_enemy:
		shoot(target_enemy)
	
func shoot(target):
	var new_bullet = bullet.instantiate()
	
	new_bullet.global_position = global_position
	
	var target_position = global_position.direction_to(target.global_position)
	new_bullet.direction = target_position
	
	new_bullet.look_at(target.global_position)
	
	get_tree().current_scene.add_child(new_bullet)
	
	
	
	
	

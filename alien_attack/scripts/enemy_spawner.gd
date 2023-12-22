extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

@onready var positions_container: Node2D = $SpawnPositions

var path_enemy_scene = preload("res://scenes/path_enemy.tscn")
var enemy_scene: Resource = preload("res://scenes/enemy.tscn") 

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var positions_array = positions_container.get_children()
	var random_position = positions_array.pick_random()
		
	var enemy_instance = enemy_scene.instantiate()
	emit_signal("enemy_spawned", enemy_instance)
	
	enemy_instance.global_position = random_position.global_position
	
func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
	


func _on_timer_path_timeout():
	spawn_path_enemy()

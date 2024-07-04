extends Node2D

@onready var player = $Player
@onready var ui = $UI
@onready var hud = $UI/HUD
@onready var player_score: int = 0
@onready var player_lives: int = 3

# Audios
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_damaged_sound = $PlayerDamagedSound

var game_over_scene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(player_score)
	hud.set_lives_left(player_lives)

func _on_death_zone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	player_lives -= 1
	hud.set_lives_left(player_lives)
	player_damaged_sound.play()
	
	
	if(player_lives == 0):
		player.die()
		
		await get_tree().create_timer(1).timeout
		
		var game_over_instance = game_over_scene.instantiate()
		game_over_instance.set_score(player_score)
		ui.add_child(game_over_instance)
	


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect('died', _on_enemy_died)
	add_child(enemy_instance)
	

func _on_enemy_died():
	player_score += 100
	hud.set_score_label(player_score)
	enemy_hit_sound.play()
	

func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect('died', _on_enemy_died)

extends Node

@onready var Coin = preload("res://coin/coin.tscn")
@onready var player = $Player
@onready var HUD = $HUD

@export var time_played: int

var level := 1
var score
var time_left
@onready var screen_size = Vector2(450,720)
var playing = false


func _ready():
	randomize()	
	
	player.window_size = screen_size
	player.hide()
	
	
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		add_coins()

func new_game():
	$HomeStreamPlayer2D2.play()
	playing = true
	level = 1
	score = 0
	time_left = 10
	
	player.init($InitialMarker2D.position)
	player.show()
	
	$Timer.start()
	add_coins()
	HUD.update_timer(time_left)
	
	
func add_coins():
	for i in range(4 + level):
		var coin = Coin.instantiate()
		$CoinContainer.add_child(coin)
		coin.position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))


func _on_timer_timeout():
	time_left -= 1
	HUD.update_timer(time_left)
		
	if time_left <= 0:
		game_over()
	
	
func game_over():
	playing = false
	$Timer.stop()
	
	for coin in $CoinContainer.get_children():
		coin.queue_free()
		
	HUD.game_over()
	player.die()
		



func _on_player_pickup():
	$CoinStreamPlayer2D.play()
	score += 1
	HUD.update_score(score)


func _on_player_hurt():
	$DieStreamPlayer2D3.play()
	game_over()

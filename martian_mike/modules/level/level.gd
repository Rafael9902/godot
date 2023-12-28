extends Node2D

@onready var start_position = $StartPosition
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"): get_tree().quit() 
	if Input.is_action_just_pressed("reset"): get_tree().reload_current_scene()


func _on_death_zone_body_entered(body):
	reset_player()


func _on_saw_touched_player():
	reset_player()


func _on_spike_ball_touched_player():
	reset_player()


func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start_position.global_position
	




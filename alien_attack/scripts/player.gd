extends CharacterBody2D

var speed: int = 400

func _physics_process(delta):
	velocity = Vector2.ZERO
	var screen_size: Vector2 = get_viewport_rect().size

	# keypress actions
	if Input.is_action_pressed("move_right"): velocity.x = speed
	if Input.is_action_pressed("move_left"): velocity.x = -speed
	if Input.is_action_pressed("move_up"): velocity.y = -speed
	if Input.is_action_pressed("move_down"): velocity.y = speed
	
	move_and_slide()
	
	# Limit the movement of the player to the screen
	global_position = global_position.clamp(Vector2.ZERO, screen_size)

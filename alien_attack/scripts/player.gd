extends CharacterBody2D

signal took_damage

var speed: int = 400
var rocket_scene: Resource = preload("res://scenes/rocket.tscn")

@onready var rocket_container: Node = $RocketContainer
@onready var shoot_sound = $ShootSound


func _process(delta):
	if Input.is_action_just_pressed("shoot"): shoot()
	
		
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


func shoot():
	shoot_sound.play()
	var rocket_instance = rocket_scene.instantiate()
	
	#add_child(rocket_instance)
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x  += 75

func take_damage():
	emit_signal('took_damage')
	

func die():
	queue_free()

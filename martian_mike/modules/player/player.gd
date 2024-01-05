extends CharacterBody2D

class_name Player

@export var speed = 200
@export var jump_force: int = 200
@export var gravity: int = 400
@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):	
	# Gravity
	if not is_on_floor(): velocity.y += gravity * delta
	
	if active == true:			
		horizontal_movement()
		vertical_movement()

		move_and_slide()
	
func horizontal_movement():
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if(direction != 0): animated_sprite.flip_h = direction < 0
	
	update_animation(direction)
	
	velocity.x = direction * speed
	
func vertical_movement():
	velocity.y = clampf(velocity.y, -500, 500)

	if Input.is_action_just_pressed("jump"):
		jump(jump_force) #and is_on_floor():

func update_animation(direction: int):
	if is_on_floor():
		if direction == 0: animated_sprite.play("idle")
		if direction != 0: animated_sprite.play("run")
		
	if not is_on_floor():
		if(velocity.y < 0): animated_sprite.play("jump")
		if(velocity.y > 0): animated_sprite.play("fall")
		


func jump(force: float):
	velocity.y = -force

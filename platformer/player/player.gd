extends CharacterBody2D

const SPEED = 120
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0.0

@onready var animation := $AnimationPlayer
@onready var sprite := $Sprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += 9

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = direction * SPEED if direction else  move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	add_animations(direction)
	
	
func add_animations(direction):
	var current_animation: String = "walk" if direction else "idle"
	animation.play(current_animation)
	
	sprite.flip_h = direction < 0 if direction != 0 else sprite.flip_h

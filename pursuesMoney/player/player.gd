extends Area2D

@export var velocity: int
var movement := Vector2()
var window_size: Vector2 = Vector2(480, 720)
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal pickup
signal hurt

#func _ready():
#	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	character_movement(delta)
	
	if movement.length() > 0:
		sprite.animation = 'run'
		
		if movement.x != 0:
			sprite.flip_h = movement.x < 0
	else:
		sprite.animation = 'idle'
		
		
func init(pos):
	position = pos
	sprite.play('idle')
	set_process(true)
	
func die():
	sprite.play('hurt')
	set_process(false)
	
func character_movement(delta):
	movement.x =  Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	movement.y =  Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
		
	position += movement.normalized() * velocity * delta
	
	position.x = clamp(position.x, 0, window_size.x)
	position.y = clamp(position.y, 0, window_size.y)
	
	init(position)


func _on_area_entered(area):
	if area.is_in_group('coins'):
		print('coin')
		area.pickup()
		emit_signal('pickup')

	if area.is_in_group('enemy'):
		emit_signal('hurt')
		die()
		

extends Area2D

@export var speed: int = 500
@onready var visible_notifier = $VisibleNotifier


func _physics_process(delta):
	global_position.x += speed*delta


func _on_visible_notifier_screen_exited():
	queue_free()


func _on_area_entered(area):
	queue_free()
	area.die()

extends Area2D

func pickup():
	# Tweens son animaciones que se ejecutan automaticamente al ser creadas
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, 'scale', Vector2(.1, .1), .5)
	tween.finished.connect(eliminate)
	
func eliminate():
	queue_free()

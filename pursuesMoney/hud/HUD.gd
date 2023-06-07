extends CanvasLayer

signal start_game

func update_score(value):
	$Menu/score_label.text = str(value)


func update_timer(value):
	$Menu/time_left_label.text = str(value)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_home_layer(text):
	$Menu/home_label.text = text
	$Menu/home_label.show()
	$Timer.start()

func _on_timer_timeout():
	$Menu/home_label.hide()


func _on_button_pressed():
	$Menu/Button.hide()
	$Menu/home_label.hide()
	emit_signal("start_game")


func game_over():
	show_home_layer('Time Out!')
	await $Timer.timeout
	$Menu/Button.show()
	$Menu/home_label.text = 'Pursues The Money!'

extends Control
	
func set_score(new_score: int):
	$Panel/Score.text = 'SCORE: ' + str(new_score)
	

func _on_retry_pressed():
	get_tree().reload_current_scene()

extends Control

@onready var score_label = $Score
@onready var lives_left = $LivesLeft

func set_score_label(score: int):
	score_label.text = 'SCORE: ' + str(score)
	
func set_lives_left(lives: int):
	lives_left.text = str(lives)

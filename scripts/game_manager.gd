extends Node

var score: int = 0
var level: int = 1

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var level_label: Label = $MarginContainer/LevelLabel

func add_points(points: int):
	score += points
	
func _process(_delta: float) -> void:
	score_label.text = str(score)
	level_label.text = "Level: " +  str(level)

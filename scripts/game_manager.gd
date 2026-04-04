extends CanvasLayer

var score: int = 0
var level: int = 8

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var level_label: Label = $MarginContainer/LevelLabel
@onready var show_fps_label: Label = $MarginContainer/FPSLabel

func _ready() -> void:
	show_fps_label.visible = false

func _process(_delta: float) -> void:
	score_label.text = str(score)
	level_label.text = "Level: " +  str(level)
	
	if show_fps_label.visible:
		show_fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

func add_points(points: int):
	score += points
	
func reset_points():
	score = 0
	level = 1
	
func toggle_show_fps_label(toggled_on):
	show_fps_label.visible = toggled_on

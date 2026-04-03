class_name MainGame

extends Node2D

@onready var brick_object = preload("res://scenes/brick.tscn")
@onready var paddle: Paddle = $Paddle
@onready var ball: Ball = $Ball
@onready var bricks: Node2D = $Bricks
@onready var ui_manager: UIManager = $UIManager
@onready var main_theme: AudioStreamPlayer2D = $MainTheme

const PADDLE_POS = Vector2(240, 240)

var cols = 26
var rows = 8
var margin = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_theme.play()
	setup_level()
	ball.game_over.connect(_on_game_over)
	connect_to_signals()
	
func connect_to_signals():
	ui_manager.start_game_requested.connect(new_level)
	ui_manager.restart_game_requested.connect(reset_level)
	ball.level_won.connect(new_level)

func setup_level():
	var colours = get_colours()
	colours.shuffle()#
	
	# setting game difficulty
	#cols = 4
	rows = 0 + GameManager.level
	if rows > 8:
		rows = 8 # limiting row length
	
	for r in rows:
		for c in cols:
			var rand_num = randi_range(0, 2)
			if rand_num > 0:
				var new_brick = brick_object.instantiate()
				bricks.add_child(new_brick)
				new_brick.position = Vector2(margin + (18 * c), margin + (18 * r))
				
				var brick_sprite = new_brick.get_node("Sprite2D")
				if r <= 7:
					brick_sprite.modulate = colours[0]
				if r <= 5:
					brick_sprite.modulate = colours[1]
				if r <= 3:
					brick_sprite.modulate = colours[2]
				if r <= 1:
					brick_sprite.modulate = colours[3]

func clear_level():
	for brick in bricks.get_children():
		brick.queue_free()
		
func reset_level():
	# reset score
	GameManager.score = 0
	GameManager.level = 1
	# clear level before instancing new one
	clear_level()
	
	# call setup_level()
	call_deferred("setup_level")
	
	# reset paddle and ball position
	paddle.position = PADDLE_POS
	ball.reset_ball()
	ball.speed = ball.BASE_SPEED

func new_level():
	clear_level()
	
	# call setup_level()
	call_deferred("setup_level")
	
	# reset paddle and ball position
	paddle.position = PADDLE_POS
	ball.reset_ball()
	
	ball.is_active = true
	# could maybe make configurable at some point? before starting game have a UI screen to set increases like this
	ball.speed = ball.speed + (7.5 * GameManager.level)

func _on_game_over():
	reset_level()
	# will change to send to another screen to enter name for high score or something
	# and option to restart or go back to main menu

func get_colours():
	var colours = [
		Color(1.0, 0.412, 0.38, 1.0),
		Color(0.6, 1.0, 1.0, 1.0),
		Color(0.467, 0.867, 0.467, 1.0),
		Color(1, 1, 1, 1),
	]
	return colours

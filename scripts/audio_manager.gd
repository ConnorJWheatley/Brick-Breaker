extends Node2D

@onready var main_theme: AudioStreamPlayer2D = $MainTheme
@onready var game_over: AudioStreamPlayer2D = $GameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().paused:
		var high_pass_filter := AudioServer.get_bus_effect(2, 0) as AudioEffectHighPassFilter
		 
		#AudioServer.set_bus_effect_enabled(1, 0, true)
		high_pass_filter.cutoff_hz = 750.0
		
	else:
		var high_pass_filter := AudioServer.get_bus_effect(2, 0) as AudioEffectHighPassFilter
		high_pass_filter.cutoff_hz = 0.0

func play_main_theme() -> void:
	game_over.stop()
	main_theme.play()
	
func play_game_over() -> void:
	main_theme.stop()
	game_over.play()

func stop_main_theme() -> void:
	main_theme.stop()
	
func stop_game_over() -> void:
	game_over.stop()

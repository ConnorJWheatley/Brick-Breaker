class_name UIManager

extends CanvasLayer

signal start_game_requested
signal restart_game_requested

@onready var main_game: MainGame = $".."
@onready var main_menu: MainMenu = $MainMenu
@onready var pause_menu: PauseMenu = $PauseMenu
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var sfx_pause: AudioStreamPlayer2D = $sfx_pause
@onready var game_over_menu: GameOver = $GameOver

enum MENU_STATE {MAIN, PAUSE, OPTIONS}
var previous_menu_state: MENU_STATE = MENU_STATE.MAIN

func _ready():
	main_menu_signals()
	pause_menu_signals()
	options_menu_signals()
	game_over_menu_signals()
	game_start_up()
	main_game.game_over.connect(_on_game_over)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		# prevents sound playing when on main menu where pressing esc does nothing
		if !main_menu.visible:
			sfx_pause.play()
		_on_pause_requested()
	
func main_menu_signals():
	main_menu.start_pressed.connect(_on_start_pressed)
	main_menu.option_pressed.connect(_on_option_pressed.bind(MENU_STATE.MAIN))
	
func pause_menu_signals():
	pause_menu.restart_button_pressed.connect(_on_restart_requested)
	pause_menu.options_button_pressed.connect(_on_option_pressed.bind(MENU_STATE.PAUSE))
	pause_menu.quit_to_main_menu_pressed.connect(_on_quit_to_menu_pressed)
	
func options_menu_signals():
	options_menu.back_pressed.connect(_on_back_pressed)
	options_menu.show_fps_toggled.connect(_on_show_fps_toggled)

func game_over_menu_signals():
	game_over_menu.restart_pressed.connect(_on_restart_requested)
	game_over_menu.main_menu_pressed.connect(_on_quit_to_menu_pressed)

func game_start_up():
	pause_menu.visible = false
	options_menu.visible = false
	game_over_menu.visible = false
	get_tree().paused = true

func pause_game():
	pause_menu.visible = true
	get_tree().paused = true
	
func _on_pause_requested() -> void:
	# check what UI state the game is in
	if main_menu.visible:
		return
	# pausing when playing game
	if pause_menu.visible == false and options_menu.visible == false:
		pause_menu.visible = true
		get_tree().paused = true
		return
	if pause_menu.visible == true:
		pause_menu.visible = false
		get_tree().paused = false
		return
	if options_menu.visible == true:
		options_menu.visible = false
		if previous_menu_state == MENU_STATE.MAIN:
			main_menu.visible = true
			previous_menu_state = MENU_STATE.OPTIONS
			return
		else:
			pause_menu.visible = true
			previous_menu_state = MENU_STATE.OPTIONS
			return

# Main Menu Signals	
func _on_start_pressed():
	main_menu.visible = false
	game_over_menu.visible = false
	get_tree().paused = false
	emit_signal("start_game_requested")
	AudioManager.play_main_theme()
	
func _on_back_pressed():
	if previous_menu_state == MENU_STATE.MAIN:
		main_menu.visible = true
	if previous_menu_state == MENU_STATE.PAUSE:
		pause_menu.visible = true
	previous_menu_state = MENU_STATE.OPTIONS
	options_menu.visible = false
	
# Pause Menu Signals
func _on_restart_requested():
	pause_menu.visible = false
	game_over_menu.visible = false
	get_tree().paused = false
	emit_signal("restart_game_requested")
	AudioManager.play_main_theme()
	
# Options Menu Signals
func _on_show_fps_toggled(toggled_on):
	GameManager.toggle_show_fps_label(toggled_on)

# Game Over
func _on_game_over():
	get_tree().paused = true
	game_over_menu.visible = true
	AudioManager.play_game_over()

# Shared
func _on_option_pressed(menu_state: MENU_STATE):
	if menu_state == MENU_STATE.MAIN:
		previous_menu_state = MENU_STATE.MAIN
	if menu_state == MENU_STATE.PAUSE:
		previous_menu_state = MENU_STATE.PAUSE
	main_menu.visible = false
	pause_menu.visible = false
	options_menu.visible = true

func _on_quit_to_menu_pressed():
	get_tree().paused = true
	pause_menu.visible = false
	game_over_menu.visible = false
	main_menu.visible = true
	AudioManager.stop_game_over()

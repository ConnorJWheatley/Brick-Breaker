class_name PauseMenu

extends Control
	
signal options_button_pressed
signal restart_button_pressed
signal quit_to_main_menu_pressed
			
func unpause_game():
	visible = false
	get_tree().paused = false

func _on_resume_btn_pressed() -> void:
	unpause_game()

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	emit_signal("restart_button_pressed")

func _on_options_btn_pressed() -> void:
	emit_signal("options_button_pressed")

func _on_quit_to_menu_btn_pressed() -> void:
	emit_signal("quit_to_main_menu_pressed")

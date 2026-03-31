class_name MainMenu

extends Control

signal start_pressed
signal option_pressed

func _on_start_btn_pressed() -> void:
	emit_signal("start_pressed")

func _on_options_btn_pressed() -> void:
	emit_signal("option_pressed")

func _on_exit_btn_pressed() -> void:
	get_tree().quit()

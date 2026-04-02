class_name MainMenu

extends Control

signal start_pressed
signal option_pressed

@onready var sfx_confirm: AudioStreamPlayer2D = $sfx_confirm

func _on_start_btn_pressed() -> void:
	sfx_confirm.play()
	emit_signal("start_pressed")

func _on_options_btn_pressed() -> void:
	sfx_confirm.play()
	emit_signal("option_pressed")

func _on_exit_btn_pressed() -> void:
	sfx_confirm.play()
	get_tree().quit()

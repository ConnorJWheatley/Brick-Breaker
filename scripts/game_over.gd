class_name GameOver

extends Control

signal restart_pressed
signal main_menu_pressed

func _on_restart_btn_pressed() -> void:
	emit_signal("restart_pressed")

func _on_main_menu_btn_pressed() -> void:
	emit_signal("main_menu_pressed")

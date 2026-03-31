class_name OptionsMenu

extends Control

signal back_pressed
signal show_fps_toggled(toggled_on)

const FPS_DICT = {
	0: 30,
	1: 60,
	2: 144,
	3: 240,
	4: 0,
}

@onready var fps_dropdown: OptionButton = $OptionsContainer/MaxFpsContainer/FPSDropdown

func _ready() -> void:
	Engine.max_fps = FPS_DICT[1]

func _on_show_fps_button_toggled(toggled_on: bool) -> void:
	emit_signal("show_fps_toggled", toggled_on)
	
func _on_fps_dropdown_item_selected(index: int) -> void:
	Engine.max_fps = FPS_DICT[index]
	fps_dropdown.selected = index

func _on_v_sync_dropdown_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_back_btn_pressed() -> void:
	emit_signal("back_pressed")

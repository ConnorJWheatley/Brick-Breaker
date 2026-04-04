class_name OptionsMenu

extends Control

signal back_pressed
signal show_fps_toggled(toggled_on)

@onready var sfx_confirm: AudioStreamPlayer2D = $sfx_confirm
@onready var sfx_cancel: AudioStreamPlayer2D = $sfx_cancel
@onready var master_volume_label: Label = $OptionsContainer/MasterVolumeContainer/MasterVolumeLabel

var master_bus := AudioServer.get_bus_index("Master")

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

func sfx_choice(toggled_on) -> void:
	if toggled_on:
		sfx_confirm.play()
	else:
		sfx_cancel.play()

func _on_show_fps_button_toggled(toggled_on: bool) -> void:
	sfx_choice(toggled_on)
	emit_signal("show_fps_toggled", toggled_on)
	
func _on_fps_dropdown_item_selected(index: int) -> void:
	Engine.max_fps = FPS_DICT[index]
	fps_dropdown.selected = index

func _on_v_sync_dropdown_toggled(toggled_on: bool) -> void:
	sfx_choice(toggled_on)
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_back_btn_pressed() -> void:
	sfx_cancel.play()
	emit_signal("back_pressed")

func _on_fps_dropdown_toggled(toggled_on: bool) -> void:
	sfx_choice(toggled_on)

func _on_h_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value) - 40
	master_volume_label.text = "Master Volume: " + str(value)
	AudioServer.set_bus_volume_db(master_bus, db)

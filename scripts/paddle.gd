class_name Paddle
extends CharacterBody2D

const SPEED = 250
const WIDTH = 16
	
func _process(delta):
	var move_direction = 0
	if Input.is_action_pressed("ui_left"):
		move_direction = -1
	elif Input.is_action_pressed("ui_right"):
		move_direction = 1

	position.x += move_direction * SPEED * delta
	position.x = clamp(position.x, 16, 464)  # Keep it inside screen (I set my screen width 600 pixels)

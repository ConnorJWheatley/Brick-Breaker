extends Node2D

@onready var brick_object = preload("res://scenes/brick.tscn")

var cols = 26
var rows = 8
var margin = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_level()
	
func setup_level():
	var colours = get_colours()
	colours.shuffle()
	
	for r in rows:
		for c in cols:
			var rand_num = randi_range(0, 2)
			if rand_num > 0:
				var new_brick = brick_object.instantiate()
				add_child(new_brick)
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

func get_colours():
	var colours = [
		Color(1.0, 0.412, 0.38, 1.0),
		Color(0.6, 1.0, 1.0, 1.0),
		Color(0.467, 0.867, 0.467, 1.0),
		Color(1, 1, 1, 1),
	]
	return colours

class_name Brick

extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var sfx_brick_destroyed: AudioStreamPlayer2D = $sfx_BrickDestroyed

func hit():
	GameManager.add_points(1)
	sprite.visible = false
	collision_shape.disabled = true
	
	sfx_brick_destroyed.play()
	
	var bricks_left = get_tree().get_nodes_in_group("Brick")
	if bricks_left.size() == 1:
		get_parent().get_parent().get_node("Ball").is_active = false
		GameManager.level += 1
		await get_tree().create_timer(1).timeout
		# send signal to restart level??
	else:
		await get_tree().create_timer(1).timeout
		queue_free()

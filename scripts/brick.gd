class_name Brick

extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

func hit():
	GameManager.add_points(1)
	sprite.visible = false
	collision_shape.disabled = true
	
	var bricks_left = get_tree().get_nodes_in_group("Brick")
	if bricks_left.size() == 1:
		get_parent().get_node("Ball").is_active = false
		await get_tree().create_timer(1).timeout
		GameManager.level += 1

	await get_tree().create_timer(1).timeout
	queue_free()

class_name Ball
extends CharacterBody2D

signal game_over

@onready var ball_sprite = $Sprite2D

var speed = 200
var is_active = true

func _ready() -> void:
	velocity = Vector2(speed * -1, speed)
	
func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		#physics_collision_detection(collision)
		arkanoid_collision_detection(collision, self)
			
func physics_collision_detection(collision: KinematicCollision2D) -> void:
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		# Push ball out of paddle slightly
		position += collision.get_normal() * 2
		
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()

func arkanoid_collision_detection(collision: KinematicCollision2D, ball: Ball) -> void:
	if collision:
		var collider = collision.get_collider()
		if collider is Paddle:			
			var offset_x = ball.position.x - collider.position.x
			var new_direction = Vector2(offset_x, -15.0).normalized()
			ball.velocity = new_direction * ball.speed
		else:
			ball.velocity = ball.velocity.bounce(collision.get_normal())
			if collider is Brick:
				var sprite = collider.get_node("Sprite2D") as Sprite2D
				var brick_colour = sprite.modulate
				ball_sprite.modulate = brick_colour
				collider.hit()

func reset_ball():
	position = Vector2(240, 223)
	velocity = Vector2(speed * -1, speed)
	ball_sprite.modulate = Color(1, 1, 1, 1)

func _on_death_zone_body_entered(_body: Node2D) -> void:
	emit_signal("game_over")

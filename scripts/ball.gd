class_name Ball
extends CharacterBody2D

var speed = 200
var direction = Vector2.DOWN
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
		# Push ball out of paddle slightlyposition += collision.get_normal() * 2
		
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
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()

func game_over():
	GameManager.score = 0
	get_tree().reload_current_scene()

func _on_death_zone_body_entered(body: Node2D) -> void:
	game_over()

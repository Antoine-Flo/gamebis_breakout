class_name Ball

extends CharacterBody2D


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	
func launch():
	set_velocity(Vector2(-450, -250))

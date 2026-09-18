extends CharacterBody2D


func _physics_process(delta: float) -> void:	
	var mouse_x = get_global_mouse_position().x
	move_and_collide(Vector2(mouse_x - global_position.x, 0))

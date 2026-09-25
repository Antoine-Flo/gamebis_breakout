class_name Ball
extends CharacterBody2D

@export var paddle: Paddle

var ball_speed = 700
var stick_to_paddle = true
const offset =  Vector2(0, -30)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
	
		if collider is TileMapLayer:
			var tilemap = collider
			var position_collision = collision.get_position()
			position_collision -= collision.get_normal() * 2
			var cell = tilemap.local_to_map(tilemap.to_local(position_collision))
			tilemap.erase_cell(cell)
		
	if stick_to_paddle:
		global_position = paddle.global_position + offset
	
func launch():
	stick_to_paddle = false
	if velocity != Vector2.ZERO:
		return
	var angle_offset = randf_range(-PI/4, PI/4)
	var direction = Vector2.UP.rotated(angle_offset)
	set_velocity(direction * ball_speed)

func die():
	velocity = Vector2.ZERO
	stick_to_paddle = true

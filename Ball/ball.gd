class_name Ball
extends CharacterBody2D

@export var paddle: Paddle

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var ball_speed = 700
var stick_to_paddle = true
const offset =  Vector2(0, -30)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		audio_stream_player.play(0.74)
		var collider = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
	
		if collider is TileMapLayer:
			var tilemap = collider
			var position_collision = collision.get_position()
			position_collision -= collision.get_normal() * 2
			var cell = tilemap.local_to_map(tilemap.to_local(position_collision))
			var cellTileData = tilemap.get_cell_tile_data(cell)
			var cellLife = cellTileData.get_custom_data("Life")
			print("before : ",cellLife)
			cellLife = cellLife - 1
			print("after : ",cellLife)
			if(cellLife <=0): 
				tilemap.erase_cell(cell)
			else:
				if(cellLife == 2):
					tilemap.set_cell(cell,2)
				elif(cellLife == 1):
					tilemap.set_cell(cell,0)
				
				
		if collider.name == "Paddle":
			var paddleCollider = collider 
			var paddle_width = paddleCollider.get_node("CollisionShape2D").shape.size.x / 2.0
			var ball_offset = global_position.x - paddleCollider.global_position.x
			var ratio = clamp(ball_offset / paddle_width, -1.0, 1.0)
			var max_angle = deg_to_rad(60.0)
			var angle = ratio * max_angle
			var speed = velocity.length()
			# J'ai piqué cette ligne
			var direction = Vector2(sin(angle),-cos(angle))
			velocity = direction * speed
			
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

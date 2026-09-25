class_name Paddle
extends CharacterBody2D

@onready var bounce_effect_hit_box: Area2D = $BounceEffectHitBox

@onready var normal: Sprite2D = $Normal
@onready var bounce: Sprite2D = $Bounce
@onready var timer: Timer = $Timer

func _ready() -> void:
	bounce_effect_hit_box.body_entered.connect(boink)
	timer.timeout.connect(boink_end)

func _physics_process(_delta: float) -> void:
	var mouse_x = get_global_mouse_position().x
	move_and_collide(Vector2(mouse_x - global_position.x, 0))

func boink(body: Node2D) -> void:
	if body is Ball:
		timer.start()
		normal.hide()
		bounce.show()
	
func boink_end() -> void:
	bounce.hide()
	normal.show()

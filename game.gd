extends Node2D

@onready var ball: CharacterBody2D = $Ball
@onready var death_zone: Area2D = $Terrain/DeathZone

func _ready() -> void:
	death_zone.body_entered.connect(death)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") or event.is_action_pressed("click"):
		ball.launch()
		
func death(body: Node2D) -> void:
	if body is Ball:
		body.die()

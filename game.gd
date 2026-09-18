extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var ball: CharacterBody2D = $Ball

func _ready() -> void:
	ball.reparent(player)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") or event.is_action_pressed("click"):
		ball.reparent(self)
		ball.launch()

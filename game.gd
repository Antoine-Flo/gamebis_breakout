extends Node2D

@onready var ball: Ball = $Ball
@onready var death_zone: Area2D = $Terrain/DeathZone
@onready var try_again_btn: Button = %TryAgainBtn
@onready var start_game_btn: Button = %StartGameBtn
@onready var new_game_btn: Button = %NewGameBtn

@onready var start_screen: Control = $HUD/StartScreen
@onready var game_over_screen: Control = $HUD/GameOverScreen
@onready var end_game_screen: Control = $HUD/EndGameScreen

@onready var bricks: TileMapLayer = $Bricks

var game_started = false
var lifes = 3
var tiles_position : PackedByteArray

func _ready() -> void:
	# Signals
	death_zone.body_entered.connect(death)
	start_game_btn.pressed.connect(start_game)
	new_game_btn.pressed.connect(new_game)
	try_again_btn.pressed.connect(new_game)
	ball.endgame.connect(endgame)

	# HUD
	game_over_screen.hide()
	end_game_screen.hide()
	start_screen.show()
	
	tiles_position = bricks.tile_map_data

func _input(event: InputEvent) -> void:
	if game_started and (event.is_action_pressed("ui_select") or event.is_action_pressed("click")):
		ball.launch()

func death(body: Node2D) -> void:
	if body is Ball:
		lifes -= 1
		body.die()
		if lifes == 0:
			gameover()

func start_game() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	start_screen.hide()
	game_started = true
	
func new_game() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	game_over_screen.hide()
	end_game_screen.hide()
	lifes = 3
	bricks.tile_map_data = tiles_position
	game_started = true

func gameover() -> void:
	game_started = false
	game_over_screen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func endgame() -> void:
	ball.die()
	game_started = false
	end_game_screen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

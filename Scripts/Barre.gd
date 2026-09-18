extends CharacterBody2D

var taille
var gLimit
var dLimit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	taille = $CollisionShape2D.shape.size.x
	gLimit = taille/2
	dLimit = get_viewport_rect().size.x - taille/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_x = get_global_mouse_position().x
	global_position.x = clamp(mouse_x, gLimit, dLimit)

extends Area2D


const DEFAULT_SPEED = 500

var rng = RandomNumberGenerator.new()
var _speed = DEFAULT_SPEED
var direction = Vector2.LEFT
var dead = false

onready var _initial_pos = position

func _ready():
	direction += Vector2(0, rng.randf_range(-0.5, 0.5))
	direction = direction.normalized()


func _process(delta):
	if dead:
		return 0
	
	_speed += delta * 2
	position += _speed * delta * direction


func reset():
	direction = Vector2.LEFT + Vector2(rng.randf_range(-0.2, 0.2), 0)
	direction = direction.normalized()
	position = _initial_pos
	_speed = DEFAULT_SPEED
	dead = false


func die():
	dead = true

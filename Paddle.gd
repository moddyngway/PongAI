extends Area2D


const MOVE_SPEED = 600

export var _ball_dir = 1
var orintation
var ball
var dead = false


onready var _screen_size_y = get_viewport_rect().size.y
var rng = RandomNumberGenerator.new()
var genom = [
	]
var init_pos

func _ready():
	var n = String(name).to_lower()
	
	init_pos = position
	ball = get_parent().get_children()[2]
	
	if _ball_dir == 1:
		orintation = Vector2.LEFT
	else:
		orintation = Vector2.RIGHT


func _process(delta):
	# Move up and down based on input.
	
	if dead:
		return 0
	
	var inputs = [
		1, #bias
		position.y / 400, #y pos
		ball.position.y / 400, # y pos of ball
		abs(ball.position.x - position.x) / 700, # y pos of ball
	]
	
	var input = 0
	
	for i in range(4):
		input += inputs[i] * genom[i]
	
	var ex = pow(2.71828, (input * 2))
	var g = 2 * ex / (1 + ex) - 1
	

	
	# var input = rng.randf_range(-1, 1)
	position.y = clamp(position.y + g * MOVE_SPEED * delta, 16, _screen_size_y - 16)


func set_genome(genome):
	self.genom = genome
	

func die():
	dead = true


func reset():
	dead = false
	position = init_pos


func _on_area_entered(area):
	if area.name == "Ball" and get_parent() == area.get_parent():
		# Assign new direction.
		area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()

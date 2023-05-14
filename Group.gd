extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var random_color
var rng = RandomNumberGenerator.new()
var genom = []
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	random_color = Color(randf(), randf(), randf(), 0.7)
	
	for node in get_children().slice(0, 1):
		node.get_children()[0].color = random_color
	get_children()[2].get_children()[1].color = random_color

func set_genome(genome):
	genom = genome
	for paddle in get_children().slice(0, 1):
		paddle.set_genome(genome)


func die():
	dead = true
	get_parent().remove_child(self)
	for child in get_children():
		child.die()


func reset():
	dead = false
	for child in get_children():
		child.reset()

extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var num_of_species = 70
var games = []
var deads = []
var rng = RandomNumberGenerator.new()
var mutation_rate = 0.7
var gen_num = 1
var Game = load("res://Game.tscn")

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in range(num_of_species):
		
		var genom = [
			rng.randf_range(-1, 1), #bias
			rng.randf_range(-1, 1), #self y pos
			rng.randf_range(-1, 1), #ball y pos
			rng.randf_range(-1, 1), #ball x pos
		]
		
		var g = Game.instance()
		g.set_genome(genom)
		games.append(g)
		add_child(g)
	
func _process(delta):
	score += 1


func die(game):
	game.die()
	deads.insert(0, game)
	
	if deads.size() == games.size():
		gen_num += 1
		#print("Generation ", gen_num)
		
		print(score)
		score = 0
		
		var t = str(gen_num)
		if t.length() < 2:
			t = "0" + t
		
		get_node("/root/MainScene/GenNum").text = t
		
		var best = deads.slice(0, int(num_of_species/10))
		var next_gen = []
		
		#print(best[0], best[0].genom)
		
		for g in best:
			next_gen.append(g.genom.duplicate(true))
		
		#print(next_gen[0])
		
		for g in best:
			for i in range(9):
				next_gen.append(mutate(g.genom.duplicate(true)))
		
		games = []
		
		for i in range(num_of_species):
			var g = Game.instance()
			g.get_children()[2].direction = (Vector2.LEFT + Vector2(0, rng.randf_range(-0.2, 0.2))).normalized()
			games.append(g)			
			add_child(g)
			g.set_genome(next_gen[i])
			
		#print(games[0].genom)
		
		deads = []
		#reset()
		

func reset():
	for g in games:
		add_child(g)


func mutate(genome):
	for i in range(genome.size()):
		if rng.randf() <= mutation_rate:
			genome[i] = genome[i] + rng.randf_range(-1, 1)
	return genome

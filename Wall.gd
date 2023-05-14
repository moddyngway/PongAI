extends Area2D


func _on_wall_area_entered(area):
	if area.name == "Ball":
		var game = area.get_parent()
		game.get_parent().die(game)
		pass


extends Node2D

onready var game = get_parent().get_parent()
var skeleton = preload("res://animals/skeleton/skeleton.tscn")


func spawn_animal(animal_scene):
	# determine spawn position and destination position
	var viewport = get_viewport()
	var spawn_pos = Vector2.ZERO
	var destination_pos = Vector2.ZERO
	var rng = RandomNumberGenerator.new()
	# spawn_loc indicates if spawning to the left, top, or right of viewport
	rng.randomize()
	var spawn_loc = rng.randi_range(0, 2)
	if spawn_loc == 0:
		# spawn will be left of map and top half of screen
		rng.randomize()
		var spawn_x = -32
		var spawn_y = rng.randi_range(0, viewport.size.y / 2)
		spawn_pos = Vector2(spawn_x, spawn_y)
		# destination will be right of viewport and bottom half of screen
		rng.randomize()
		var destination_x = viewport.size.x + 32
		var destination_y = rng.randi_range(viewport.size.y / 2, viewport.size.y)
		destination_pos = Vector2(destination_x, destination_y)
	elif spawn_loc == 1:
		# spawn will be above viewport
		rng.randomize()
		var spawn_x = rng.randi_range(0, viewport.size.x)
		var spawn_y = -32
		spawn_pos = Vector2(spawn_x, spawn_y)
		# destination will be below viewport
		rng.randomize()
		var destination_x = rng.randi_range(0, viewport.size.x)
		var destination_y = viewport.size.y + 32
		destination_pos = Vector2(destination_x, destination_y)
	elif spawn_loc == 2:
		# spawn will be right of viewport and top half of screen
		rng.randomize()
		var spawn_x = viewport.size.x + 32
		var spawn_y = rng.randi_range(0, viewport.size.y / 2)
		spawn_pos = Vector2(spawn_x, spawn_y)
		# destination will be left of viewport and bottom half of screen
		rng.randomize()
		var destination_x = -32
		var destination_y = rng.randi_range(viewport.size.y / 2, viewport.size.y)
		destination_pos = Vector2(destination_x, destination_y)
	
	# spawn and initialize animal
	var animal_instance = animal_scene.instance()
	animal_instance.global_position = spawn_pos
	animal_instance.destination = destination_pos
	add_child(animal_instance)
	

func _on_SpawnTimer_timeout():
	# todo: factor in player count and make spawn logic more dynamic
	if game.difficulty == 0:
		spawn_animal(skeleton)
	elif game.difficulty == 1:
		spawn_animal(skeleton)
		spawn_animal(skeleton)
	elif game.difficulty == 2:
		spawn_animal(skeleton)
		spawn_animal(skeleton)
		spawn_animal(skeleton)
	elif game.difficulty >= 3:
		spawn_animal(skeleton)
		spawn_animal(skeleton)
		spawn_animal(skeleton)
		spawn_animal(skeleton)

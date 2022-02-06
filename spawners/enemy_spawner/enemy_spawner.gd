extends Node2D

onready var game = get_parent().get_parent()
var skeleton = preload("res://enemies/skeleton/skeleton.tscn")

func spawn_enemy(enemy_scene):
	# determine spawn position and destination position
	var viewport = get_viewport()
	var half_viewport_width = viewport.size.x / 2
	var half_viewport_height = viewport.size.y / 2
	var spawn_pos = Vector2.ZERO
	var destination_pos = Vector2.ZERO
	var rng = RandomNumberGenerator.new()
	# spawn_loc indicates if spawning to the left, top, or right of viewport
	rng.randomize()
	var spawn_loc = rng.randi_range(0, 2)
	print(spawn_loc)
	if spawn_loc == 0:
		# spawn will be left of viewport and top half of screen
		rng.randomize()
		var spawn_x = (half_viewport_width * -1) -32
		var spawn_y = rng.randi_range(0, half_viewport_height)
		spawn_pos = Vector2(spawn_x, spawn_y)
		# destination will be right of viewport and bottom half of screen
		rng.randomize()
		var destination_x = half_viewport_width + 32
		var destination_y = rng.randi_range(half_viewport_height, viewport.size.y)
		destination_pos = Vector2(destination_x, destination_y)
	elif spawn_loc == 1:
		# spawn will be above viewport
		rng.randomize()
		var spawn_x = rng.randi_range(half_viewport_width * -1, half_viewport_width)
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
		var spawn_x = half_viewport_width + 32
		var spawn_y = rng.randi_range(0, half_viewport_height)
		spawn_pos = Vector2(spawn_x, spawn_y)
		# destination will be left of viewport and bottom half of screen
		rng.randomize()
		var destination_x = (half_viewport_width * -1) -32
		var destination_y = rng.randi_range(half_viewport_height, viewport.size.y)
		destination_pos = Vector2(destination_x, destination_y)
	
	# spawn and initialize enemy
	var enemy_instance = enemy_scene.instance()
	enemy_instance.global_position = spawn_pos
	enemy_instance.destination = destination_pos
	add_child(enemy_instance)
	

func _on_SpawnTimer_timeout():
	# todo: factor in player count and make spawn logic more dynamic
	if game.difficulty == 0:
		spawn_enemy(skeleton)
	elif game.difficulty == 1:
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)
	elif game.difficulty == 2:
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)
	elif game.difficulty >= 3:
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)
		spawn_enemy(skeleton)

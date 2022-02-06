extends Node2D

onready var game = get_parent().get_parent()
onready var viewport_width = get_viewport().size.x
var skeleton = preload("res://enemies/skeleton/skeleton.tscn")

func _ready():
	print("difficulty: " + str(game.difficulty))
	print("screen_size: " + str(viewport_width))


func _on_SpawnTimer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if game.difficulty == 0:
		randomize()
		var x = rng.randi_range(0, viewport_width)
		print("x: " + str(x))
		var skeleton_instance = skeleton.instance()
		skeleton_instance.global_position = Vector2(x, 0)
		add_child(skeleton_instance)

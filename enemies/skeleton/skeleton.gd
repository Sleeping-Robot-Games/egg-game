extends KinematicBody2D

export (int) var move_speed = 120
export (int) var vision_range = 80
export (String, 'Left', 'Right', 'Front', 'Back') var default_facing = 'Front'

onready var anim_player = $AnimationPlayer
onready var exclamation = $Exclamation

var despawn_if_offscreen = false
var velocity = Vector2.ZERO
var destination = Vector2.ZERO
var node_target = null
var player: KinematicBody2D = null
var facing = "Right"


func _physics_process(delta):
	# only despawn if off screen after enemy has first appeared on screen
	if not despawn_if_offscreen and get_node("VisibilityNotifier2D").is_on_screen():
		despawn_if_offscreen = true
	elif despawn_if_offscreen and not get_node("VisibilityNotifier2D").is_on_screen():
		queue_free()
	
	# move towards target
	var target = destination
	if node_target:
		target = node_target.global_position
	velocity = global_position.direction_to(target) * move_speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		pass
	
	# animate sprite based on movement direction
	animate_sprite(global_position, target)


func animate_sprite(from, to):
	# determine which way to face enemy based on prior position
	var dir = from.direction_to(to)
	var dominant_axis = "x" if abs(dir.x) > abs(dir.y) else "y"
	var new_facing = facing
	if dominant_axis == "x":
		new_facing = "Right" if dir.x > 0 else "Left"
	else:
		new_facing = "Front" if dir.y > 0 else "Back"

	anim_player.play("Walk" + new_facing)
		
	# animate enemy in appropriate direction
	if facing != new_facing:
		facing = new_facing
		anim_player.play("Walk" + facing)


#func chase_check():
#	if player:
#		var direction_to_player = global_position.direction_to(player.global_position)
#		raycast.cast_to = direction_to_player * vision_range
#		raycast.force_raycast_update()
#		var collision_object = raycast.get_collider()
#		if collision_object == player:
#			show_icon("exclamation")
#			state = "chase"

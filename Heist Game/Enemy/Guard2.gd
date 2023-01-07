extends "res://Objects/PlayerDetection.gd"


var velocity = Vector2.ZERO

export var path_to__player := NodePath()
onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var _player: KinematicBody2D = get_node(path_to__player)
onready var sprite: Sprite = $Sprite

onready var guard: KinematicBody2D = $"."


var motion 
var possible_destinations
var path 

export var min_arrival_dist = 5
export var walk_speed = .5


func _ready() -> void:
	randomize()
	#Find and track _player
	
	pass
	

func _physics_process(delta: float) -> void:
	
	guard.rotation = velocity.angle()
	
	
	if agent.is_navigation_finished():
		return 
	
	#Get the next location
	var direction = global_position.direction_to(agent.get_next_location())
	
	var desired_velocity = direction * 30
	var steering = (desired_velocity - velocity) * delta * 4
	velocity += steering
	velocity = move_and_slide(velocity)
	
	
	pass



func _on_Timer_timeout() -> void:
	

	
#	make_path()
	pass # Replace with function body.




func _on_DetectionRange_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	agent.set_target_location(_player.global_position)
	$Timer.start()
	guard.rotation = velocity.angle()
	
	
	pass # Replace with function body.


func _on_Torch_visibility_changed() -> void:
	agent.set_target_location(_player.global_position)
	pass # Replace with function body.
	guard.rotation = velocity.angle()
	
	

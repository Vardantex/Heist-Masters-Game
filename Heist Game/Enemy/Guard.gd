extends "res://Objects/PlayerDetection.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D",true, false)
onready var destinations = navigation.get_node("Destinations")


var velocity = Vector2.ZERO

export onready var targetDest = NodePath()
onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var player: KinematicBody2D = $"../../../Player"
onready var guard: KinematicBody2D = $"."


var motion 
var possible_destinations
var path 

export var min_arrival_dist = 5
export var walk_speed = .5


func _ready() -> void:
	randomize()
	#Find and track player
	agent.set_target_location(player.global_position)
#	possible_destinations = destinations.get_children()
#	make_path()
	

func _physics_process(delta: float) -> void:
	
#	navigate()
	
	#Get the next location
	var direction = global_position.direction_to(agent.get_next_location())
	
	var desired_velocity = direction * 30
	var steering = (desired_velocity - velocity) * delta * 4
	velocity += steering
	velocity = move_and_slide(velocity)
	
	
	pass

func navigate():
	#error here
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > min_arrival_dist:
		move()
	else:
		update_path()


func move():
	#look at where guard is moving to
	look_at(path[0])
	
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	
	move_and_slide(motion)

func update_path():
	if path.size() == 1:
		if$Timer.is_stopped():
			$Timer.start
		else:
			path.remove[0]
	

func make_path():
	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
	path = navigation.get_simple_path(position, new_destination.position)
	print(path)

func _on_Timer_timeout() -> void:
	
	agent.set_target_location(player.global_position)
	
#	make_path()
	pass # Replace with function body.


func _on_DetectionRange_body_entered(body: Node) -> void:
	
	$Timer.start()
	
	
	pass # Replace with function body.

extends "res://Temp/TemplateCharacter.gd"


const FOV_TOLERANCE = 20 
const MAX_DETECTION_RANGE = 320
const RED = Color(1,0.25,.25)
const WHITE = Color(1,1,1)

var Player

func _ready() -> void:
	
	#Search for the Player node in the scene
	Player = get_node("/root").find_node("Player", true, false)
	
	pass

func _process(delta: float) -> void:
	
	if Player_in_FOV() and Player_in_LOS():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
		
		

func Player_in_LOS():
	
	#Get info on the 2d world
	var space = get_world_2d().direct_space_state
	#intersect ray draws a line (From, To, Exclude, layerToInteractWith)
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	if not LOS_obstacle:
		return false
	
	#Get distance of player
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	#Set the camera LOS Range
	var Player_in_Range = distance_to_player < MAX_DETECTION_RANGE
	
	#Check if camera is colliding with player
	if LOS_obstacle.collider == Player and Player_in_Range:
		return true
	else:
		return false
	

func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	#absolute: check for angle direction regardless of +/-
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true 
	else:
		return false
			

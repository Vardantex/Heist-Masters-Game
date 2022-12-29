extends "res://Temp/TemplateCharacter.gd"


const FOV_TOLERANCE = 20 
const RED = Color(1,0.25,.25)
const WHITE = Color(1,1,1)

var Player

func _ready() -> void:
	
	#Search for the Player node in the scene
	Player = get_node("/root").find_node("Player", true, false)
	
	pass

func _process(delta: float) -> void:
	
	if Player_in_FOV():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
		
		

func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	#absolute: check for angle direction regardless of +/-
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true 
	else:
		return false
			

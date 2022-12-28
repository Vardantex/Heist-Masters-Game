extends "res://Temp/TemplateCharacter.gd"


var motion = Vector2()

func _physics_process(delta: float) -> void:

	update_movement()
	move_and_slide(motion)
	pass
	


func update_movement():
	
	if(Input.is_action_pressed("CLOSE_GAME")):
		get_tree().quit()
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("WASD_DOWN") and not Input.is_action_pressed("WASD_UP"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
		
	elif Input.is_action_pressed("WASD_UP") &&! Input.is_action_pressed("WASD_DOWN"):
		motion.y = clamp(motion.y -SPEED, -MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		
	if Input.is_action_pressed("WASD_LEFT") and not Input.is_action_pressed("WASD_RIGHT"):
		motion.x = clamp(motion.x -SPEED, -MAX_SPEED, 0)
		
	
	elif Input.is_action_pressed("WASD_RIGHT") &&! Input.is_action_pressed("WASD_LEFT"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		
	
	pass
	

func _input(event):
	if Input.is_action_just_pressed("LIGHT_TOGGLE"):
		$Torch.enabled = !$Torch.enabled


func _ready() -> void:
	pass

extends "res://Objects/Door.gd"


func _ready() -> void:
	pass

func _on_Door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/NumPad.popup_centered()
	


func _on_Door_body_exited(body: Node) -> void:
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/NumPad.hide()
	


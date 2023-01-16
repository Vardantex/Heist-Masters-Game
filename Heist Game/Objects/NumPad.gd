extends Popup


var combination = [0,4,5,1]
var guess = []

onready var display = $VBoxContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight


signal combination_correct

func _ready() -> void:
	
	connect_buttons()
#	reset_lock()
	
	

#Connect pressed buttons in the grid container
func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		#Checks if the recieved node is a type Button
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])
		#Connect as method pressed, to self, Do this method, store as
	


func Button_pressed(button):
	if button == "OK":
		check_guess()
	else:
		enter(int(button))
	
	pass

func check_guess():
	
	if guess == combination:
		emit_signal("combination_correct")
	else:
		reset_lock()
	
	pass


func enter(button):
	
	guess.append(button)
	update_display()
	
	


func update_display():
	#this will display as a single string
	display.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()
	

func reset_lock():
	
	light.texture = load("res://Assets/GFX/Interface/PNG/dotRed.png")
	display.text = ""
	guess.clear()
	
	
	
	






extends LineEdit

const ControllerManager = preload("res://scripts/ControllerManager.gd")

@onready var bubble = $"../../../../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	var value = bubble.get_value(get_parent().name,name)
	if (value != null):
		text = str(value)

func save():
	match name:
		"AuthKey":
			bubble.set_value(get_parent().name,name,text)
		"Port":
			var b = int(text)
			if (b < 1024):
				b = 1024
			if (b > 49151):
				b = 49151
			bubble.set_value(get_parent().name,name,b)
		"Intensity":
			var b = int(text)
			if (b < 1):
				b = 1
			if (b > 100):
				b = 100
			bubble.set_value(get_parent().name,name,b)
		"Duration":
			var b = float(text)
			if (b < 0.1):
				b = 0.1
			if (b > 15):
				b = 15
			bubble.set_value(get_parent().name,name,b)
		"Delay":
			var b = float(text)
			if (b < 0.1):
				b = 0.1
			if (b > 30):
				b = 30
			bubble.set_value(get_parent().name,name,b)

func _exit_tree():
	save()
	
func _on_text_changed(new_text):
	save()

const action_binds = ["ui_up", "ui_down", "ui_left", "ui_right", "ui_cancel","ui_accept","exit game", "reset"]

var locked_in = false
func _input(event):
	if self.has_focus():
		if event is InputEventMouseButton:
			var click : InputEventMouseButton = event
			if (!click.is_pressed()):
				locked_in = true
			print(str(event))
		
		if event is InputEventKey:
			var key : InputEventKey = event
			for action_bind in action_binds:
				if (key.is_action(action_bind)):
					#get_viewport().handle_input_locally = true
					if key.pressed:
						if len(OS.get_keycode_string(key.keycode)) == 1:
							get_viewport().set_input_as_handled()
							var temp_column = caret_column + 1
							var key_whole : String = str(key)
							if key_whole.contains("mods=Shift"):
								text = text.insert(caret_column,OS.get_keycode_string(key.keycode))
							else:
								text = text.insert(caret_column,OS.get_keycode_string(key.keycode).to_lower())
							caret_column = temp_column
						else:
							match action_bind:
								"ui_up":
									if (locked_in):
										get_viewport().set_input_as_handled()
									pass
								"ui_down":
									if (locked_in):
										get_viewport().set_input_as_handled()
									pass
								"ui_left":
									if (locked_in):
										get_viewport().set_input_as_handled()
										if caret_column>0:
											caret_column -= 1
								"ui_right":
									if (locked_in):
										get_viewport().set_input_as_handled()
										if caret_column<len(text):
											caret_column += 1
								"ui_cancel":
									if (locked_in):
										get_viewport().set_input_as_handled()
										if caret_column>0:
											var temp_column = caret_column - 1
											text = text.erase(caret_column-1)
											caret_column = temp_column
								"ui_accept":
									get_viewport().set_input_as_handled()
									locked_in = true
								"exit game":
									if (locked_in):
										get_viewport().set_input_as_handled()
										locked_in = false
								"reset":
									pass
					break
	pass # Replace with function body.


func _on_focus_exited():
	locked_in = false
	pass # Replace with function body.


func _on_focus_entered():
	pass # Replace with function body.

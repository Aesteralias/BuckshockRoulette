extends Button

@onready var bubble = $"../../../../.."
var s_node 

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	s_node = Node.new()
	s_node.set_name("Socket")
	s_node.set_script(load("res://mods-unpacked/Aes-PiShock/Socket.gd"))
	add_child(s_node)
	pass # Replace with function body.


func _pressed():
	s_node.send_setup_message()
	pass
	

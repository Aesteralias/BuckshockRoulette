extends CheckBox

@onready var bubble = $"../../../../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	var value = bubble.get_value(get_parent().name,name)
	if (value != null):
		button_pressed = value
	

func save():
	bubble.set_value(get_parent().name,name,button_pressed)

func _exit_tree():
	save()

extends "res://scripts/Debugging.gd"

var config_scene = preload("res://mods-unpacked/Aes-PiShock/ModConfig.tscn")
var config_instance

func _unhandled_input(event):
	if (event is InputEventKey):
		if event.pressed and event.keycode == KEY_P:
			if (config_instance == null):
				if (get_parent().name == "standalone managers"):
					if (get_parent().get_parent().name == "menu"):
						config_instance = config_scene.instantiate()
						get_tree().root.add_child(config_instance)
			else:
				get_tree().root.remove_child(config_instance)
				config_instance = null
				pass
	super(event)

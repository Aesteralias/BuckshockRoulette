extends "res://multiplayer/scripts/MP_PacketManager.gd"


var stored_health = 100
var jam_lock = false
var used_meds = false
var printing_time = true
var properties = null
var socket_number = null
var round_running = false
var s_node
var c_node

func _ready():
	c_node = Node.new()
	c_node.set_name("Config")
	c_node.set_script(load("res://mods-unpacked/Aes-PiShock/ModConfig.gd"))
	add_child(c_node)
	
	s_node = Node.new()
	s_node.set_name("Socket")
	s_node.set_script(load("res://mods-unpacked/Aes-PiShock/Socket.gd"))
	add_child(s_node)
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (instance_handler != null):
		if (instance_handler.instance_property_array != null):
			for instance in instance_handler.instance_property_array:
				if (instance!=null):
					if instance.is_active == true:
						properties = instance
						socket_number = properties.socket_number
						
	
	
	if properties != null:
		if (properties.health_current>0):
			if (properties.is_jammed and !properties.jammer_checked and !jam_lock and round_running):
				jam_lock = true
				s_node.send_event("Jammed")
				jam_delay()
				pass
	super(_delta)
	pass


func PipeData(dict : Dictionary):
	var value_category = dict.values()[0]
	var value_alias = dict.values()[1]
	
	if (value_category=="MP_RoundManager"):
		if (value_alias == "end turn"):
			if (dict.user_won_game_at_socket != -1):
				round_running = false
		if (value_alias == "first round routine"):
			round_running = true
			
	if (value_category=="MP_UserInstanceProperties"):
		for instance in instance_handler.instance_property_array:
			if instance.is_active:
				match value_alias:
					"shoot user":
						if (dict.shooter_socket_target==socket_number):
							if (dict.shooter_shell == "live"):
								if (dict.shooter_socket_self==socket_number):
									if (dict.barrel_sawed_off):
										if (properties.health_current>2):
											s_node.send_event("Double_Self_Shot")
										else:
											s_node.send_event("Double_Self_Death")
									else:
										if (properties.health_current>1):
											s_node.send_event("Single_Self_Shot")
										else:
											s_node.send_event("Single_Self_Death")
								else:
									if (dict.barrel_sawed_off):
										if (properties.health_current>2):
											s_node.send_event("Double_Dealer_Shot")
										else:
											s_node.send_event("Double_Dealer_Death")
									else:
										if (properties.health_current>1):
											s_node.send_event("Single_Dealer_Shot")
										else:
											s_node.send_event("Single_Dealer_Death")
							else:
								if (dict.shooter_socket_self==socket_number):
									s_node.send_event("Blank_Self")
								else:
									s_node.send_event("Blank_Dealer")
						elif (dict.shooter_socket_self!=socket_number and dict.shooter_socket_self==socket_number):
							if (dict.shooter_shell == "blank"):
								s_node.send_event("Blank_Offense")
							else:
								if (dict.barrel_sawed_off):
									s_node.send_event("Double_Offense_Shot")
								else:
									s_node.send_event("Single_Offense_Shot")
							
					"interact with item":
						if (dict.socket_number==socket_number):
							print(dict.item_id)
							match dict.item_id:
								1: #"handsaw":
									s_node.send_event("Handsaw_Use")
									pass
								2: #"magnifying glass":
									s_node.send_event("Magnifying_Use")
									pass
								3: #"jammer":
									s_node.send_event("Jammer_Use")
									pass
								4: #"cigarettes":
									s_node.send_event("Cigarette_Use")
									pass
								5: #"beer":
									s_node.send_event("Beer_Use")
									pass
								6: #"burner phone":
									s_node.send_event("Phone_Use")
									pass
								7: #"expired medicine":
									#used_meds = true
									pass
								8: #"adrenaline":
									s_node.send_event("Adrenaline_Use")
									pass
								9: #"inverter":
									s_node.send_event("Inverter_Use")
									pass
								10: #"remote":
									s_node.send_event("Reverse_Use")
									pass
	super(dict)
	pass


func print_delay():
	await(get_tree().create_timer(5).timeout)
	printing_time = true

#func meds_delay():
#	await(get_tree().create_timer(4).timeout)
#	used_meds = false
	
func jam_delay():
	var delay = c_node.get_value("JammedTimer","Refresh")
	if (delay == null):
		delay = 10
	await(get_tree().create_timer(delay).timeout)
	jam_lock = false

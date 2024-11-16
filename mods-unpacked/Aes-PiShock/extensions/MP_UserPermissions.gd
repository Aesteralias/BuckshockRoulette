extends "res://multiplayer/scripts/user scripts/MP_UserPermissions.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#is_active or bp_turn.visible = true (is your turn?) 

#User Inventory = [{},{},{},{},{},{},{},{}]
#var dict = {
#	"item_name" = item name,
#	"item_instance" = item parent object,
#	"item_id" = item id,
#}

#health_current

#socket_number

#shotgun.active_shooter_socket_target
#shotgun.active_shooter_shell
#shotgun.active_shooter_shotgun_damage

var stored_health = -1
var stored_inventory = [null,null,null,null,null,null,null,null]
var jam_lock = false
var used_meds = false
var printing_time = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (printing_time):
		printing_time=false
		print(properties.is_active)
		
		print(stored_health)
		print(properties.health_current)
		
		for i in range(len(properties.user_inventory)):
			print(stored_inventory[i])
			if (properties.user_inventory[i] != {} and properties.user_inventory[i] != null):
				print(properties.user_inventory[i].item_name)
	
	if (properties.is_active):
		if (stored_health > properties.health_current):
			if (used_meds):
				if (properties.health_current <= 0):
					print("Meds Death")
					pass # meds death
				else:
					print("Meds Damage")
					pass # meds damage
			else:
				if (properties.health_current <= 0):
					print("Dead")
					pass # Dead
				else:
					print("Damage")
					pass #lost health
		for i in range(len(properties.user_inventory)):
			if (stored_inventory[i] != null and properties.user_inventory[i] == {}):
				print(stored_inventory[i])
				
				match stored_inventory[i]:
					1: #"handsaw":
						pass
					2: #"magnifying glass":
						pass
					3: #"jammer":
						pass
					4: #"cigarettes":
						pass
					5: #"beer":
						pass
					6: #"burner phone":
						pass
					7: #"expired medicine":
						used_meds = true
						pass
					8: #"adrenaline":
						pass
					9: #"inverter":
						pass
					10: #"remote":
						pass
				stored_inventory[i] = null
		if (properties.is_jammed):
			if (!jam_lock):
				print("Jammed")
				jam_lock = true
				jam_delay()
				pass # constant shock until resolved
	else:
		pass
	
	stored_health = properties.health_current
	for i in range(len(properties.user_inventory)):
		if (properties.user_inventory[i] != {} and properties.user_inventory[i] != null):
			stored_inventory[i] = int(properties.user_inventory[i].item_id)
		else:
			stored_inventory[i] = null
	
	pass

func print_delay():
	await(get_tree().create_timer(10).timeout)
	printing_time = true

func meds_delay():
	await(get_tree().create_timer(4).timeout)
	used_meds = false
	
func jam_delay():
	await(get_tree().create_timer(1).timeout)
	jam_lock = false

#func ReceivePacket_TimeoutExceeded(packet : Dictionary):
#	if (packet.timeout_type == "adrenaline"):
#		print("Adrenaline Timeout")
#		pass
#	if (packet.timeout_type == "jammer"):
#		print("Jammer Timeout")
#		pass
#	super(packet)

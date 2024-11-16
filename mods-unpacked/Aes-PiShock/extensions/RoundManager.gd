extends "res://scripts/RoundManager.gd"


var check_locked = true
var current_total_items = []
var current_player_health
var current_dealer_health
var current_shells_loaded
var medicine_taken = false
var is_player_turn = false
var cuff_zap = true
var disable_continious = false

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!check_locked):
		print_current_game_state()
		check_health_loss()
		pass
		
	if (playerCuffed and cuff_zap and not disable_continious):
		cuff_zap = false
		s_node.send_event("Handcuffed")
	
	super(delta)
	pass

func EndTurn(playerCanGoAgain : bool):
	if (playerCanGoAgain):
		if (playerCuffed and !playerAboutToBreakFree):
			print("Dealer Turn")
			is_player_turn = false
		else:
			is_player_turn = true
			print("Player Turn")
	else:
		if (dealerCuffed and !dealerAI.dealerAboutToBreakFree):
			is_player_turn = true
			print("Player Turn")
		else:
			print("Dealer Turn")
			is_player_turn = false
	super(playerCanGoAgain)



func StartRound(gettingNext : bool):
	check_locked = true
	is_player_turn = true
	print("Player Starts")
	super(gettingNext)
	
	update_caches()



func update_caches():
	current_player_health = health_player
	current_dealer_health = health_opponent
	
	current_shells_loaded = shellSpawner.sequenceArray.size()
	
	if (current_total_items.size()<amounts.array_amounts.size()):
		current_total_items.resize(amounts.array_amounts.size())
	
	for i in range(amounts.array_amounts.size()):
		current_total_items[i] = amounts.array_amounts[i].amount_player + amounts.array_amounts[i].amount_dealer
	
	if (shellSpawner != null):
		if (shellSpawner.sequenceArray!=null):
			if (shellSpawner.sequenceArray.size()>0):
				print("Next Shell: " + str(shellSpawner.sequenceArray[0])) 
	pass



func LoadShells():
	super()
	update_caches()
	check_locked = false
	pass



func check_health_loss():
	if (current_dealer_health > health_opponent):
		print("Dealer Health:" + str(health_opponent))
		if (health_opponent <= 0):
			check_locked = true
	current_dealer_health = health_opponent
	
	if (current_player_health > health_player):
		print("Player Health:" + str(health_player))
		if (medicine_taken):
			if (health_player<=0):
				s_node.send_event("Pill_Death")
				check_locked = true
				disable_continious = true
			else:
				s_node.send_event("Pill_Damage")
		else:
			if (current_player_health-2 == health_player):
				if (is_player_turn):
					if (health_player<=0):
						print("Double Self Death")
						s_node.send_event("Double_Self_Death")
						check_locked = true
						disable_continious = true
					else:
						print("Double Self Damage")
						s_node.send_event("Double_Self_Shot")
				else:
					if (health_player<=0):
						print("Double Dealer Kill")
						s_node.send_event("Double_Dealer_Death")
						check_locked = true
						disable_continious = true
					else:
						print("Double Dealer Shot")
						s_node.send_event("Double_Dealer_Shot")
			else:
				if (is_player_turn):
					if (health_player<=0):
						print("Single Self Death")
						s_node.send_event("Single_Self_Death")
						check_locked = true
						disable_continious = true
					else:
						print("Single Self Damage")
						s_node.send_event("Single_Self_Shot")
				else:
					if (health_player<=0):
						print("Single Dealer Kill")
						s_node.send_event("Single_Dealer_Death")
						check_locked = true
						disable_continious = true
					else:
						print("Single Dealer Shot")
						s_node.send_event("Single_Dealer_Shot")
	current_player_health=health_player
	pass


func print_current_game_state():
	
	
	if (current_shells_loaded != shellSpawner.sequenceArray.size()):
		print("Number of Shells:" + str(shellSpawner.sequenceArray.size()))
		if (shellSpawner != null):
			if (shellSpawner.sequenceArray!=null):
				if (shellSpawner.sequenceArray.size()>0):
					print("Next Shell: " + str(shellSpawner.sequenceArray[0])) 
					
	current_shells_loaded = shellSpawner.sequenceArray.size()
	
	for i in range(amounts.array_amounts.size()):
		if (current_total_items[i] > amounts.array_amounts[i].amount_player + amounts.array_amounts[i].amount_dealer):
			print("Number of Total " + amounts.array_amounts[i].itemName + ": " + str(amounts.array_amounts[i].amount_player + amounts.array_amounts[i].amount_dealer))
			if (is_player_turn):
				match (amounts.array_amounts[i].itemName):
					"handcuffs":
						s_node.send_event("Handcuff_Use")
					"beer":
						s_node.send_event("Beer_Use")
					"magnifying glass":
						s_node.send_event("Magnifying_Use")
					"cigarettes":
						s_node.send_event("Cigarette_Use")
					"handsaw":
						s_node.send_event("Handsaw_Use")
					"expired medicine":
						medicine_taken = true
						medicine_timeout()
						pass
					"inverter":
						s_node.send_event("Inverter_Use")
					"burner phone":
						s_node.send_event("Phone_Use")
					"adrenaline":
						s_node.send_event("Adrenaline_Use")
						pass
		current_total_items[i] = amounts.array_amounts[i].amount_player + amounts.array_amounts[i].amount_dealer
		
		
	#for item in amounts.array_amounts:
	#	print(item.itemName)
	#	print("Player has:" + str(item.amount_player) + "     Dealer has:" + str(item.amount_dealer)) 
	#await get_tree().create_timer(1).timeout
	pass
	
func medicine_timeout():
	await get_tree().create_timer(6).timeout
	medicine_taken = false
	print("Medicine Effects Completed")
	
func cuffed_timeout():
	await get_tree().create_timer(1).timeout
	cuff_zap = true
	

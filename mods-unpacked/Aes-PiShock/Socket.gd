extends Node

var websocket_url = "ws://localhost:8765"

enum action {shock, vibrate, beep, end}
enum selector {all, random}

# Our WebSocketClient instance.

static var socket = WebSocketPeer.new()
static var stopping = 0

const Configs = preload("res://mods-unpacked/Aes-PiShock/ModConfig.gd")

func send_setup_message() -> void:
	stopping += 1
	
	var c_key = Configs.get_value("Util","AuthKey")
	if c_key != null:
		var packet = {"cmd": "get_devices", "auth_key": c_key, "value":"v"}
		packet = JSON.stringify(packet)
		socket.send_text(packet)
	
	stopping -= 1

func send_event(event_name: String) -> void:
	stopping += 1
	
	
	var data = Configs.get_values(event_name)
	if (!data['enabled']):
		stopping -= 1
		return
		
	var packet = {"cmd": "operate", "auth_key": data['auth']}
	
	
	var delay = data['delay']
	
	data.erase('auth')
	data.erase('delay')
	data.erase('enabled')
	
	if (data['device_ids']==[] and data['shocker_ids']==[]):
		var dec = Configs.get_value("Util", "Device_Ids")
		if (dec != null):
			for devic in dec:
				data['device_ids'].append(devic['id'])
	
	data['action'] = action.keys()[data['action']]
	data['shocker_option'] = selector.keys()[data['shocker_option']]
	packet['value'] = data
	
	var package = JSON.stringify(packet)
	print(package)
	await get_tree().create_timer(delay).timeout
	socket.send_text(package)
	stopping -= 1
	
func _exit_tree():
	while stopping > 0:
		await get_tree().process_frame
	socket.close()


func _ready():
	print_debug("Starting Socket Connection")
	
	var c_url = Configs.get_value("Util", "Port")
	if (c_url != null):
		websocket_url = "ws://localhost:" + str(c_url)
	
	socket.poll()
	var state = socket.get_ready_state()
	
	if (state == WebSocketPeer.STATE_OPEN or state==WebSocketPeer.STATE_CONNECTING):
		print_debug("Readied Again")
		return
	
	# Initiate connection to the given URL.
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		print_debug("Failed to Connect")
		print("Unable to connect")
		set_process(false)
	else:
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout
		socket.send_text("Test Message!")

func _process(delta):
	# Call this in _process or _physics_process. Data transfer and state updates
	# will only happen when calling this function.
	socket.poll()

	# get_ready_state() tells you what state the socket is in.
	var state = socket.get_ready_state()

	# WebSocketPeer.STATE_OPEN means the socket is connected and ready
	# to send and receive data.
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var so_d = socket.get_packet().get_string_from_utf8()
			so_d = JSON.parse_string(so_d)
			#print("Got data from server: ", so_d)
			
			var device_hold = []
			var shocker_hold = []
			for device in so_d:
				if (device['shockers'] != null):
					for element in device['shockers']:
						element['dev_id'] = device['id']
					shocker_hold.append_array(device['shockers'])
				device.erase('shockers')
				device_hold.append(device)
				
			var d_id = Configs.get_value("Util","Device_Ids")
			
			var new_entry = true
			
			if (d_id==null):
				d_id = device_hold
			else:
				for prospect in device_hold:
					new_entry = true
					for device in d_id:
						if (device['id'] == prospect['id']):
							device['name'] = prospect['name']
							new_entry = false
							break
					if (new_entry):
						d_id.append(prospect)
					
			
			var s_id = Configs.get_value("Util","Shocker_Ids")
			if (s_id==null):
				s_id = shocker_hold
			else:
				for prospect in shocker_hold:
					new_entry = true
					for shocker in s_id:
						if (shocker['identifier'] == prospect['identifier']):
							shocker['name'] = prospect['name']
							shocker['dev_id'] = prospect['dev_id']
							new_entry = false
							break
					if (new_entry):
						s_id.append(prospect)
			
			print(d_id)
			print(s_id)
			
			Configs.set_value("Util", "Device_Ids", d_id)
			Configs.set_value("Util", "Shocker_Ids", s_id)
			

	# WebSocketPeer.STATE_CLOSING means the socket is closing.
	# It is important to keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# WebSocketPeer.STATE_CLOSED means the connection has fully closed.
	# It is now safe to stop polling.
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be -1 if the disconnection was not properly notified by the remote peer.
		var code = socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.

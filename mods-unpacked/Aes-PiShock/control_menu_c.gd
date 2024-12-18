extends MenuButton


@onready var bubble = $"../../../../.."
var current_device_count = 0
var loaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_a()
	loaded = true
	
func load_a():
	var p = get_popup()
	p.clear()
	
	p.hide_on_checkable_item_selection = false
	p.hide_on_item_selection = false
	p.hide_on_state_item_selection = false
	
	var dev_val = bubble.get_value(get_parent().name,"Device_Ids")
	var device_listing = bubble.get_value("Util","Device_Ids")
	
	var sho_val = bubble.get_value(get_parent().name,"Shocker_Ids")
	var shock_listing = bubble.get_value("Util","Shocker_Ids")
	
	if (current_device_count  != device_listing.size()+shock_listing.size() and loaded):
		self.text = "Devices [!]"
	elif (device_listing.size()+shock_listing.size() != 0 and (dev_val != null and sho_val != null)):
		text = "Devices [" + str(dev_val.size()+sho_val.size()) + "]"
	else:
		text = "Devices []"
	
	var ind = 0
	p.id_pressed.connect(_on_item_menu_pressed)
	p.index_pressed.connect(_on_item_menu_pressed)
	if (device_listing != null):
		for element in device_listing:
			p.add_check_item(element['name'],element['id'])
			if (dev_val != null):
				for sel in dev_val:
					if (sel==element['id']):
						p.set_item_checked(p.get_item_index(element['id']), true)
						break
			if (shock_listing != null):
				for sub_element in shock_listing:
					if (sub_element['dev_id'] == element['id']):
						p.add_check_item(sub_element['name'],sub_element['identifier'])
						p.set_item_indent(p.get_item_index(sub_element['identifier']),1)
						if (sho_val != null):
							for sel in sho_val:
								if sel==sub_element['identifier']:
									p.set_item_checked(p.get_item_index(sub_element['identifier']), true)
						
	current_device_count = get_popup().item_count 

func _on_item_menu_pressed(id: int):
	var p = get_popup()
	p.set_item_checked(id, (not get_popup().is_item_checked(id)))
	
	
	if (p.get_item_indent(id)==0):
		var i = id + 1
		while p.get_item_indent(i)==1:
			p.set_item_checked(i, p.is_item_checked(id))
			i = i + 1
	elif (p.get_item_indent(id)==1):
		var i = id - 1
		while p.get_item_indent(i)==1:
			i = i - 1
		var ii = i + 1
		p.set_item_checked(i,true)
		while p.get_item_indent(ii)==1:
			if (p.is_item_checked(ii)==false):
				p.set_item_checked(i,false)
				break
			ii =  ii + 1
		
	
	var d_count = 0
	
	for i in range(p.item_count):
		if (p.is_item_checked(i)):
			d_count+= 1
			
	text = "Devices [" + str(d_count) + "]"

func save():
	var dev_ids = []
	var sho_ids = []
	
	var p = get_popup()
	
	for i in range(p.item_count):
		if (p.is_item_checked(i)):
			if (p.get_item_indent(i)==1):
				sho_ids.append(p.get_item_id(i))
			else:
				dev_ids.append(p.get_item_id(i))
	
	bubble.set_value(get_parent().name,"Device_Ids",dev_ids)
	bubble.set_value(get_parent().name,"Shocker_Ids",sho_ids)

func _exit_tree():
	save()


func _on_timer_timeout():
	save()
	load_a()

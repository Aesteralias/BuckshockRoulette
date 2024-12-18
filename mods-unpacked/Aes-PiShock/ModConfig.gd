extends Node


static var config_values = ConfigFile.new()

var user_base_path = OS.get_user_data_dir()

const config_name = "/Aes-PiShock-config.cfg"

func _init():
	var err = config_values.load(user_base_path+config_name)
	if (err != OK or !config_values.has_section("Util")): #If it cannot load config, set Default Values
		config_values.set_value("Util", "AuthKey","")
		config_values.set_value("Util", "Port", 8765)
		config_values.set_value("Util", "Device_Ids",[])
		config_values.set_value("Util", "Shocker_Ids",[])
	
	if (err != OK or !config_values.has_section("Blank_Self")):
		config_values.set_value("Blank_Self","Enabled", false)
		config_values.set_value("Blank_Self","Operation", 1)
		config_values.set_value("Blank_Self","Intensity", 16)
		config_values.set_value("Blank_Self","Duration", 1.0)
		config_values.set_value("Blank_Self","Shockers", 1)
		config_values.set_value("Blank_Self","Shocker_Ids", [])
		config_values.set_value("Blank_Self","Device_Ids", [])
		config_values.set_value("Blank_Self","Delay", 0.5)
		
	if (err != OK or !config_values.has_section("Single_Self_Shot")):
		config_values.set_value("Single_Self_Shot","Enabled", true)
		config_values.set_value("Single_Self_Shot","Operation", 0)
		config_values.set_value("Single_Self_Shot","Intensity", 20)
		config_values.set_value("Single_Self_Shot","Duration", 1.0)
		config_values.set_value("Single_Self_Shot","Shockers", 1)
		config_values.set_value("Single_Self_Shot","Shocker_Ids", [])
		config_values.set_value("Single_Self_Shot","Device_Ids", [])
		config_values.set_value("Single_Self_Shot","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Single_Self_Death")):
		config_values.set_value("Single_Self_Death","Enabled", true)
		config_values.set_value("Single_Self_Death","Operation", 0)
		config_values.set_value("Single_Self_Death","Intensity", 40)
		config_values.set_value("Single_Self_Death","Duration", 2.0)
		config_values.set_value("Single_Self_Death","Shockers", 0)
		config_values.set_value("Single_Self_Death","Shocker_Ids", [])
		config_values.set_value("Single_Self_Death","Device_Ids", [])
		config_values.set_value("Single_Self_Death","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Double_Self_Shot")):
		config_values.set_value("Double_Self_Shot","Enabled", true)
		config_values.set_value("Double_Self_Shot","Operation", 0)
		config_values.set_value("Double_Self_Shot","Intensity", 33)
		config_values.set_value("Double_Self_Shot","Duration", 1.5)
		config_values.set_value("Double_Self_Shot","Shockers", 1)
		config_values.set_value("Double_Self_Shot","Shocker_Ids", [])
		config_values.set_value("Double_Self_Shot","Device_Ids", [])
		config_values.set_value("Double_Self_Shot","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Double_Self_Death")):
		config_values.set_value("Double_Self_Death","Enabled", true)
		config_values.set_value("Double_Self_Death","Operation", 0)
		config_values.set_value("Double_Self_Death","Intensity", 66)
		config_values.set_value("Double_Self_Death","Duration", 3.0)
		config_values.set_value("Double_Self_Death","Shockers", 0)
		config_values.set_value("Double_Self_Death","Shocker_Ids", [])
		config_values.set_value("Double_Self_Death","Device_Ids", [])
		config_values.set_value("Double_Self_Death","Delay", 0.1)
		
	if (err != OK or !config_values.has_section("Blank_Dealer")):
		config_values.set_value("Blank_Dealer","Enabled", false)
		config_values.set_value("Blank_Dealer","Operation", 1)
		config_values.set_value("Blank_Dealer","Intensity", 16)
		config_values.set_value("Blank_Dealer","Duration", 1.0)
		config_values.set_value("Blank_Dealer","Shockers", 1)
		config_values.set_value("Blank_Dealer","Shocker_Ids", [])
		config_values.set_value("Blank_Dealer","Device_Ids", [])
		config_values.set_value("Blank_Dealer","Delay", 0.6)
	
	if (err != OK or !config_values.has_section("Single_Dealer_Shot")):
		config_values.set_value("Single_Dealer_Shot","Enabled", true)
		config_values.set_value("Single_Dealer_Shot","Operation", 0)
		config_values.set_value("Single_Dealer_Shot","Intensity", 20)
		config_values.set_value("Single_Dealer_Shot","Duration", 1.0)
		config_values.set_value("Single_Dealer_Shot","Shockers", 1)
		config_values.set_value("Single_Dealer_Shot","Shocker_Ids", [])
		config_values.set_value("Single_Dealer_Shot","Device_Ids", [])
		config_values.set_value("Single_Dealer_Shot","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Single_Dealer_Death")):
		config_values.set_value("Single_Dealer_Death","Enabled", true)
		config_values.set_value("Single_Dealer_Death","Operation", 0)
		config_values.set_value("Single_Dealer_Death","Intensity", 40)
		config_values.set_value("Single_Dealer_Death","Duration", 2.0)
		config_values.set_value("Single_Dealer_Death","Shockers", 0)
		config_values.set_value("Single_Dealer_Death","Shocker_Ids", [])
		config_values.set_value("Single_Dealer_Death","Device_Ids", [])
		config_values.set_value("Single_Dealer_Death","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Double_Dealer_Shot")):
		config_values.set_value("Double_Dealer_Shot","Enabled", true)
		config_values.set_value("Double_Dealer_Shot","Operation", 0)
		config_values.set_value("Double_Dealer_Shot","Intensity", 33)
		config_values.set_value("Double_Dealer_Shot","Duration", 1.5)
		config_values.set_value("Double_Dealer_Shot","Shockers", 1)
		config_values.set_value("Double_Dealer_Shot","Shocker_Ids", [])
		config_values.set_value("Double_Dealer_Shot","Device_Ids", [])
		config_values.set_value("Double_Dealer_Shot","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Double_Dealer_Death")):
		config_values.set_value("Double_Dealer_Death","Enabled", true)
		config_values.set_value("Double_Dealer_Death","Operation", 0)
		config_values.set_value("Double_Dealer_Death","Intensity", 66)
		config_values.set_value("Double_Dealer_Death","Duration", 3.0)
		config_values.set_value("Double_Dealer_Death","Shockers", 0)
		config_values.set_value("Double_Dealer_Death","Shocker_Ids", [])
		config_values.set_value("Double_Dealer_Death","Device_Ids", [])
		config_values.set_value("Double_Dealer_Death","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Blank_Offense")):
		config_values.set_value("Blank_Offense","Enabled", false)
		config_values.set_value("Blank_Offense","Operation", 0)
		config_values.set_value("Blank_Offense","Intensity", 16)
		config_values.set_value("Blank_Offense","Duration", 1.5)
		config_values.set_value("Blank_Offense","Shockers", 1)
		config_values.set_value("Blank_Offense","Shocker_Ids", [])
		config_values.set_value("Blank_Offense","Device_Ids", [])
		config_values.set_value("Blank_Offense","Delay", 0.6)
	
	if (err != OK or !config_values.has_section("Single_Offense_Shot")):
		config_values.set_value("Single_Offense_Shot","Enabled", false)
		config_values.set_value("Single_Offense_Shot","Operation", 1)
		config_values.set_value("Single_Offense_Shot","Intensity", 24)
		config_values.set_value("Single_Offense_Shot","Duration", 1.0)
		config_values.set_value("Single_Offense_Shot","Shockers", 1)
		config_values.set_value("Single_Offense_Shot","Shocker_Ids", [])
		config_values.set_value("Single_Offense_Shot","Device_Ids", [])
		config_values.set_value("Single_Offense_Shot","Delay", 0.4)
	
	if (err != OK or !config_values.has_section("Double_Offense_Shot")):
		config_values.set_value("Double_Offense_Shot","Enabled", false)
		config_values.set_value("Double_Offense_Shot","Operation", 1)
		config_values.set_value("Double_Offense_Shot","Intensity", 32)
		config_values.set_value("Double_Offense_Shot","Duration", 2.0)
		config_values.set_value("Double_Offense_Shot","Shockers", 0)
		config_values.set_value("Double_Offense_Shot","Shocker_Ids", [])
		config_values.set_value("Double_Offense_Shot","Device_Ids", [])
		config_values.set_value("Double_Offense_Shot","Delay", 0.4)
	
	if (err != OK or !config_values.has_section("Adrenaline_Use")):
		config_values.set_value("Adrenaline_Use","Enabled", false)
		config_values.set_value("Adrenaline_Use","Operation", 0)
		config_values.set_value("Adrenaline_Use","Intensity", 16)
		config_values.set_value("Adrenaline_Use","Duration", 8.0)
		config_values.set_value("Adrenaline_Use","Shockers", 1)
		config_values.set_value("Adrenaline_Use","Shocker_Ids", [])
		config_values.set_value("Adrenaline_Use","Device_Ids", [])
		config_values.set_value("Adrenaline_Use","Delay", 0.5)
	
	if (err != OK or !config_values.has_section("Pill_Damage")):
		config_values.set_value("Pill_Damage","Enabled", false)
		config_values.set_value("Pill_Damage","Operation", 0)
		config_values.set_value("Pill_Damage","Intensity", 20)
		config_values.set_value("Pill_Damage","Duration", 5.0)
		config_values.set_value("Pill_Damage","Shockers", 0)
		config_values.set_value("Pill_Damage","Shocker_Ids", [])
		config_values.set_value("Pill_Damage","Device_Ids", [])
		config_values.set_value("Pill_Damage","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Pill_Death")):
		config_values.set_value("Pill_Death","Enabled", false)
		config_values.set_value("Pill_Death","Operation", 0)
		config_values.set_value("Pill_Death","Intensity", 50)
		config_values.set_value("Pill_Death","Duration", 10.0)
		config_values.set_value("Pill_Death","Shockers", 0)
		config_values.set_value("Pill_Death","Shocker_Ids", [])
		config_values.set_value("Pill_Death","Device_Ids", [])
		config_values.set_value("Pill_Death","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Handcuff_Use")):
		config_values.set_value("Handcuff_Use","Enabled", false)
		config_values.set_value("Handcuff_Use","Operation", 0)
		config_values.set_value("Handcuff_Use","Intensity", 32)
		config_values.set_value("Handcuff_Use","Duration", 4)
		config_values.set_value("Handcuff_Use","Shockers", 1)
		config_values.set_value("Handcuff_Use","Shocker_Ids", [])
		config_values.set_value("Handcuff_Use","Device_Ids", [])
		config_values.set_value("Handcuff_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Handcuffed")):
		config_values.set_value("Handcuffed","Enabled", false)
		config_values.set_value("Handcuffed","Operation", 0)
		config_values.set_value("Handcuffed","Intensity", 12)
		config_values.set_value("Handcuffed","Duration", 5.0)
		config_values.set_value("Handcuffed","Shockers", 1)
		config_values.set_value("Handcuffed","Shocker_Ids", [])
		config_values.set_value("Handcuffed","Device_Ids", [])
		config_values.set_value("Handcuffed","Delay", 0.1)
		
	if (err != OK or !config_values.has_section("HandcuffedTimer")):
		config_values.set_value("HandcuffedTimer","Refresh", 10)
	
	if (err != OK or !config_values.has_section("Jammer_Use")):
		config_values.set_value("Jammer_Use","Enabled", false)
		config_values.set_value("Jammer_Use","Operation", 0)
		config_values.set_value("Jammer_Use","Intensity", 32)
		config_values.set_value("Jammer_Use","Duration", 4)
		config_values.set_value("Jammer_Use","Shockers", 1)
		config_values.set_value("Jammer_Use","Shocker_Ids", [])
		config_values.set_value("Jammer_Use","Device_Ids", [])
		config_values.set_value("Jammer_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Jammed")):
		config_values.set_value("Jammed","Enabled", false)
		config_values.set_value("Jammed","Operation", 0)
		config_values.set_value("Jammed","Intensity", 12)
		config_values.set_value("Jammed","Duration", 5.0)
		config_values.set_value("Jammed","Shockers", 1)
		config_values.set_value("Jammed","Shocker_Ids", [])
		config_values.set_value("Jammed","Device_Ids", [])
		config_values.set_value("Jammed","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("JammedTimer")):
		config_values.set_value("JammedTimer","Refresh", 10)
	
	if (err != OK or !config_values.has_section("Beer_Use")):
		config_values.set_value("Beer_Use","Enabled", false)
		config_values.set_value("Beer_Use","Operation", 0)
		config_values.set_value("Beer_Use","Intensity", 18)
		config_values.set_value("Beer_Use","Duration", 2)
		config_values.set_value("Beer_Use","Shockers", 1)
		config_values.set_value("Beer_Use","Shocker_Ids", [])
		config_values.set_value("Beer_Use","Device_Ids", [])
		config_values.set_value("Beer_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Cigarette_Use")):
		config_values.set_value("Cigarette_Use","Enabled", false)
		config_values.set_value("Cigarette_Use","Operation", 0)
		config_values.set_value("Cigarette_Use","Intensity", 21)
		config_values.set_value("Cigarette_Use","Duration", 4)
		config_values.set_value("Cigarette_Use","Shockers", 1)
		config_values.set_value("Cigarette_Use","Shocker_Ids", [])
		config_values.set_value("Cigarette_Use","Device_Ids", [])
		config_values.set_value("Cigarette_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Magnifying_Use")):
		config_values.set_value("Magnifying_Use","Enabled", false)
		config_values.set_value("Magnifying_Use","Operation", 0)
		config_values.set_value("Magnifying_Use","Intensity", 24)
		config_values.set_value("Magnifying_Use","Duration", 2.0)
		config_values.set_value("Magnifying_Use","Shockers", 1)
		config_values.set_value("Magnifying_Use","Shocker_Ids", [])
		config_values.set_value("Magnifying_Use","Device_Ids", [])
		config_values.set_value("Magnifying_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Phone_Use")):
		config_values.set_value("Phone_Use","Enabled", false)
		config_values.set_value("Phone_Use","Operation", 0)
		config_values.set_value("Phone_Use","Intensity", 16)
		config_values.set_value("Phone_Use","Duration", 2)
		config_values.set_value("Phone_Use","Shockers", 1)
		config_values.set_value("Phone_Use","Shocker_Ids", [])
		config_values.set_value("Phone_Use","Device_Ids", [])
		config_values.set_value("Phone_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Handsaw_Use")):
		config_values.set_value("Handsaw_Use","Enabled", false)
		config_values.set_value("Handsaw_Use","Operation", 0)
		config_values.set_value("Handsaw_Use","Intensity", 3)
		config_values.set_value("Handsaw_Use","Duration", 4)
		config_values.set_value("Handsaw_Use","Shockers", 1)
		config_values.set_value("Handsaw_Use","Shocker_Ids", [])
		config_values.set_value("Handsaw_Use","Device_Ids", [])
		config_values.set_value("Handsaw_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Inverter_Use")):
		config_values.set_value("Inverter_Use","Enabled", false)
		config_values.set_value("Inverter_Use","Operation", 0)
		config_values.set_value("Inverter_Use","Intensity", 24)
		config_values.set_value("Inverter_Use","Duration", 3)
		config_values.set_value("Inverter_Use","Shockers", 1)
		config_values.set_value("Inverter_Use","Shocker_Ids", [])
		config_values.set_value("Inverter_Use","Device_Ids", [])
		config_values.set_value("Inverter_Use","Delay", 0.1)
	
	if (err != OK or !config_values.has_section("Reverse_Use")):
		config_values.set_value("Reverse_Use","Enabled", false)
		config_values.set_value("Reverse_Use","Operation", 0)
		config_values.set_value("Reverse_Use","Intensity", 8)
		config_values.set_value("Reverse_Use","Duration", 4)
		config_values.set_value("Reverse_Use","Shockers", 1)
		config_values.set_value("Reverse_Use","Shocker_Ids", [])
		config_values.set_value("Reverse_Use","Device_Ids", [])
		config_values.set_value("Reverse_Use","Delay", 0.1)

static func get_values(category: String):
	if (config_values.has_section(category)):
		var args = {"warning": false, "held": false}
		args["auth"] = config_values.get_value("Util", "AuthKey")
		args["enabled"] = config_values.get_value(category, "Enabled")
		args["delay"] = config_values.get_value(category, "Delay")
		args["action"] = config_values.get_value(category, "Operation")
		args["intensity"] = config_values.get_value(category, "Intensity")
		args["duration"] = config_values.get_value(category, "Duration")
		args["shocker_option"] = config_values.get_value(category, "Shockers")
		args["shocker_ids"] = config_values.get_value(category, "Shocker_Ids")
		args["device_ids"] = config_values.get_value(category, "Device_Ids")
		return args
	return null

static func get_value(category: String, part: String):
	if (config_values.has_section(category)):
		return config_values.get_value(category,part)
		
static func set_value(category: String, part: String, value: ):
	config_values.set_value(category,part,value)


func _exit_tree():
	print_debug("Aes-PiShock: Saving Config at:"+user_base_path+config_name)
	config_values.save(user_base_path+config_name)

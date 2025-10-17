A BRML mod that uses MultiShock Websockets for PiShock Devices <br/>
There has been fairly minimal testing past it not crashing upon light dev use. <br/>

Events are:
-You shoot yourself for {1/2} damage and {Live/Die} <br/>
-Someone else shoots you for {1/2} damage and you {Live/Die} <br/>
-Shooting another player in multiplayer with a Blank or Live round <br/>
-Every 10 (Configurable) seconds if you are handcuffed or jammed <br/>
-Using Each item <br/>
	-Expired Medicine if you take damage and {Live/Die} <br/>
 <br/>

Requirements:<br/>
	-Godot Mod Loader https://github.com/GodotModding/godot-mod-loader/releases <br/>
	Or <br/>
	-Buckshot Roulette Mod Loader https://github.com/AGO061/BuckshotRouletteModLoader <br/>
	<br/>
	-MultiShock https://mshock.akiradev.me/ <br/>


Setup: <br/>
-Godot Mod Loader <br/>
	Download the latest Self-Setup (Tested with 7.0.1-WIN) <br/>
	Extract the folder and put the subsequent addons folder alongside the game folder <br/>
		-It should be ...Steam/steamapps/common/Buckshot_Roulette/addons <br/>
	Open the launch parameters of Buckshot and add: <br/>
		"--script addons/mod_loader/mod_loader_setup.gd --setup-create-override-cfg" <br/>
			If this doesn't work, go into addons/mod_loader/mod_loader_setup.gd <br/>
	Launch the game and it should create a godot folder alongside the addons folder <br/>
	Create a mods folder alongside the .exe <br/>
		-It should be ...Steam/steamapps/common/Buckshot_Roulette/Buckshot Roulette_windows/mods <br/>
	<br/>
	
-MultiShock <br/>
	Once installed, in the settings tab of MultiShock, you need to both; <br/>
		-Login to your pishock account that contains PiShock devices <br/>
		-Save a Websocket Auth Key <br/>
	<br/>
	
-Installing Mod <br/>
	Download the Latest Aes-PiShock.Zip <br/>
	Put that into the mod folder <br/>
	<br/>

-Configuration <br/>
	Before playing either mode you need to enter and set some configurations <br/>
		-(Godot Mod Loader)When the menu is open press the "P" key to toggle the config <br/>
		-(Buckshot Mod Loader)When the game is open click "Mods" <br/>
			-Click the Gear top Right of the PiShock Mod Listing <br/>
		-Set the Same Auth Key as MultiShock <br/>
		-Ping MultiShock for your Devices <br/>
		-Set what events you want enabled and what command to send on each event <br/>
		-Exit out of the config menu

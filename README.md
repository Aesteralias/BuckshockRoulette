A BRML mod that uses MultiShock Websockets for PiShock Devices <br/>
There has been fairly minimal testing past it not crashing upon light dev use. <br/>

Events are: <br/>
- You shoot yourself for {1/2} damage and {Live/Die}
- Someone else shoots you for {1/2} damage and you {Live/Die}
- Shooting another player in multiplayer with a Blank or Live round
- Every 10 (Configurable) seconds if you are handcuffed or jammed
- Using Each item 
  - Expired Medicine if you take damage and {Live/Die}
 <br/>

Requirements:<br/>
	  - Godot Mod Loader https://github.com/GodotModding/godot-mod-loader/releases
	Or <br/>
	  - Buckshot Roulette Mod Loader https://github.com/AGO061/BuckshotRouletteModLoader
	  - MultiShock https://mshock.akiradev.me/


Setup: <br/>
- Godot Mod Loader
  - Download the latest Self-Setup (Tested with 7.0.1-WIN)
  - Extract the folder and put the subsequent addons folder alongside the game folder
	- (It should be ...Steam/steamapps/common/Buckshot_Roulette/addons)
  - Open the launch parameters of Buckshot and add:
	- "--script addons/mod_loader/mod_loader_setup.gd --setup-create-override-cfg"
	  - If this doesn't work, go into addons/mod_loader/mod_loader_setup.gd
  - Launch the game and it should create a godot folder alongside the addons folder
  - Create a mods folder alongside the .exe
	- It should be ...Steam/steamapps/common/Buckshot_Roulette/Buckshot Roulette_windows/mods
	<br/>
	
- MultiShock
  - Once installed, in the settings tab of MultiShock, you need to both;
	- Login to your pishock account that contains PiShock devices
	- Save a Websocket Auth Key
	<br/>
	
- Installing Mod
  - Download the Latest Aes-PiShock.Zip 
  - Put that into the mod folder
	<br/>

- Configuration 
  - Before playing either mode you need to enter and set some configurations
	- (Godot Mod Loader)When the menu is open press the "P" key to toggle the config
	- (Buckshot Mod Loader)When the game is open click "Mods"
	  - Click the Gear top Right of the PiShock Mod Listing
	- Set the Same Auth Key as MultiShock
	- Ping MultiShock for your Devices
	- Set what events you want enabled and what command to send on each event
	- Exit out of the config menu

A BRML mod that uses MultiShock Websockets for PiShock Devices

There has been fairly minimal testing past it not crashing upon light dev use.

Events are:

-You shoot yourself for {1/2} damage and {Live/Die}

-Someone else shoots you for {1/2} damage and you {Live/Die}

-Shooting another player in multiplayer with a Blank or Live round.

-Every 10 (Configurable) seconds if you are handcuffed or jammed

-Using Each item
	-Expired Medicine if you take damage and {Live/Die}


Requirements: 
	-Buckshot Roulette Mod Loader https://github.com/AGO061/BuckshotRouletteModLoader
	-MultiShock https://mshock.akiradev.me/


Setup:
-MultiShock
	Once installed, in the settings tab of MultiShock, you need to both; 
		-Login to your pishock account that contains PiShock devices
		-Save a Websocket Auth Key

-Installing Mod
	Download the Latest Aes-PiShock.Zip
	Put that into the mod folder

-Configuration
	Before playing either mode you need to enter and set some configurations
		-When the game is open click "Mods"
		-Click the Gear top Right of the PiShock Mod Listing
		-Set the Same Auth Key as MultiShock
		-Ping MultiShock for your Devices
		-Set what events you want enabled and what command to send on each event
		-Exit out of the config menu

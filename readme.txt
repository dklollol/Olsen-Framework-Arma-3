Framework Version: 3.1.1

For information on how to make a mission please visit:
https://github.com/dklollol/Olsen-Framework-Arma-3/wiki/Making-your-first-mission



Functions documentation:
	This section documents all public functions.


FNC_InArea

	Description:
		Checks if unit is within area of marker, supports all shapes

	Parameters:
		- unit [object]
		- name of marker [string]

	Returns:
		is unit in marker [bool]

	Example:
		[player, "minefield"] call FNC_InArea

		Result:
			true/false depending on unit's position
			Returned: true/false [bool]


FNC_AreaCount

	Description:
		Counts units on set side in area of set diameter around object.
		
	Parameters:
		- side [side]
		- radius [number]
		- center of area [object]
		- Ignore Untracked units [bool] (def: false)

	Returns:
		amount of units in area [number]

	Example:
		[WEST, 100, base] call FNC_AreaCount

		Result:
			units in set area are counted
			Returned: 10


FNC_EndMission

	Description:
		Ends mission in orderly fashion and displays end screen.

	Parameters:
		- text to display in end screen [string]

	Returns:
		nothing

	Example:
		"USMC Victory" call FNC_EndMission

		Result:
			mission is ended and above message is displayed on end screen
			Returned: nothing


FNC_CasualtyPercentage

	Description:
		Returns casualty percentage for set team

	Parameters:
		- team [string]

	Returns:
		casualty percentage (1-100) [number]

	Example:
		"USMC" call FNC_CasualtyPercentage
		Result:
			casualty percentage for USMC is returned
			Returned: 70 [number]


FNC_CasualtyCount

	Description:
		Counts number of casualties on set team

	Parameters:
		- team [string]

	Returns:
		casualty count [number]

	Example:
		"USMC" call FNC_CasualtyCount

		Result:
			number of casualties for USMC is returned
			Returned: 10 [number]


FNC_Alive

	Description:
		Checks if unit is considered alive by framework

	Parameters:
		- unit [object]

	Returns:
		unit's state [bool]

	Example:
		player call FNC_Alive

		Result:
			player's state is returned
			Returned: true [bool]


FNC_HasEmptyPositions

	Description:
		checks if vehicle has available positions

	Parameters:
		- vehicle [object]

	Returns:
		empty positions [bool]

	Example:
		(vehicle player) call FNC_HasEmptyPositions

		Result:
			player's vehicle has no free positions
			Returned: false [bool]


FNC_InVehicle

	Description:
		Checks if unit is in a vehicle

	Parameters:
		- unit [object]

	Returns:
		is unit in a vehicle [bool]

	Example:
		player call FNC_InVehicle

		Result:
			yep
			Returned: true [bool]


FNC_AddTeam

	Description:
		Adds team

	Parameters:
		- side of new team [side]
		- name of new team [string]
		- type of new team: "ai"/"player" [string]
	Returns:
		nothing

	Example:
		[WEST, "NATO", "player"] call FNC_AddTeam

		Result:
			new team is created
			Returned: nothing


FNC_NotTrackUnit

	Description:
		Disable tracking of unit by framework

	Parameters:
		- unit [object]

	Returns:
		nothing

	Example:
		player call FNC_NotTrackUnit

		Result:
			player is not tracked by framework
			Returned: nothing


FNC_DebugMessage

	Description:
		Display on-screen debug message.

	Parameters:
		- message [string]

	Returns:
		nothing

	Example:
		"Hello World" call FNC_DebugMessage

		Result:
			debug message displayed
			Returned: nothing


FNC_TrackAsset

	Description:
		Sets asset to be tracked by framework

	Parameters:
		- asset [object]
		- name of asset [string]
		- team of asset [string]

	Returns:
		nothing

	Example:
		[tank, "T90", "VDV"] call FNC_TrackAsset

		Result:
			Asset is tracked
			Returned: nothing


FNC_RemoveAllGear

	Description:
		Removes all gear from unit.

	Parameters:
		- unit [object]

	Returns:
		nothing

	Example:
		player call FNC_RemoveAllGear

		Result:
			player's gear removed
			Returned: nothing


FNC_RemoveAllVehicleGear

	Description:
		Clear cargo of a vehicle.

	Parameters:
		- vehicle [object]

	Returns:
		nothing

	Example:
		tank call FNC_RemoveAllVehicleGear

		Result:
			tank's cargo cleared
			Returned: nothing


FNC_GearScript

	Description:
		Run gearscript on set unit.

	Parameters:
		- unit to run gearscript for [object]
		- loadout name [string]
		- group name [string] (OPTIONAL)

	Returns:
		nothing

	Example:
		[this, "SL", "1'1"] call FNC_GearScript

		Result:
			Add SL loadout to unit, set it's group name to 1'1.
			Returned: nothing


FNC_VehicleGearScript

	Description:
		Add set loadout to vehicle.

	Parameters:
		- vehicle [object]
		- loadout type [string]

	Returns:
		nothing

	Example:
		[this, "HUMMVEE"] call FNC_VehicleGearScript

		Result:
			Vehicle receives HUMVEE loadout.
			Returned: nothing


FNC_AddItem

	Description:
		Add item to local unit. Can specify container and amount.

	Parameters:
		- classname of item [string]
		- amount of item to add [number] (OPTIONAL)
		- container name "uniform"/"vest"/"backpack" available [string] (OPTIONAL)

	Returns:
		nothing

	Example:
		["ItemMap", 1, "uniform"] call FNC_AddItem;

		Result:
			Map added to uniform.
			Returned: nothing


FNC_AddItemRandom

	Description:
		Add item random to local unit. Can specify container and amount.
		For more info, visit https://github.com/dklollol/Olsen-Framework-Arma-3/wiki/gear.sqf

	Parameters:
		n/a

	Returns:
		nothing

	Example:
		n/a

		Result:
			n/a


FNC_AddItemVehicle

	Description:
		Add item to vehicle's cargo.

	Parameters:
		- classname of item [string]
		- amount [number] (OPTIONAL)

	Returns:
		nothing

	Example:
		["30Rnd_556x45_Stanag", 8] call FNC_AddItemVehicle

		Result:
			8 STANAGS added to vehicle inventory.


FNC_AddItemVehicleRandom

	Description:
		Add random item to vehicle's cargo.

	Parameters:
		n/a

	Returns:
		nothing

	Example:
		n/a

		Result:
			n/a



Internal gearscript's functions:
FNC_CanLinkItem
FNC_CanAttachItem
FNC_AddItemOrg
FNC_AddItemRandomOrg
FNC_AddItemVehicleOrg
FNC_AddItemVehicleRandomOrg
FNC_Chance

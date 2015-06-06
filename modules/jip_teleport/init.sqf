["JIP Teleport", "Adds an action to JIP players that allows them to teleport to their SL.", "Olsen"] call FNC_RegisterModule;

#include "settings.sqf"

if (!isDedicated) then {
	
	_target = leader player;
	
	if (player == _target || !(_target call FNC_Alive)) then {
	
		_rank = -1;
	
		{
		
			if (rankId _x > _rank && (_target call FNC_Alive)) then {
				_rank = rankId _x;
				_target = _x;
			};
			
		} forEach ((units group player) - [player]);
	};

	if ((_target distance player) >  JIPDISTANCE) then {
	
		_teleportAction = player addAction ["Teleport to Squad", "modules\jip_teleport\teleportAction.sqf", _target];
		
		[_teleportAction] spawn { //Spawns code running in parallel
		
			_spawnPos = getPosATL player;
			
			while {true} do {
			
				if (player distance _spawnPos > SPAWNDISTANCE) exitWith { //Exitwith ends the loop
				
					player removeAction (_this select 0);
					cutText [format ["JIP teleport option lost, you went beyond %1 meters from your spawn location", SPAWNDISTANCE], 'PLAIN DOWN'];
					
				};
				
				sleep (60); //Runs every min
				
			};
		};
	};
};

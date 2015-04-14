_id = _this select 2;
_target = _this select 3;

_allDead = false;

if (!(alive _target) || _target getVariable ["frameworkDead", false]) then {
	
	_rank = -1;

	{
		if (rankId _x > _rank && (alive _target) && !(_x getVariable ["frameworkDead", false]) && (!((vehicle _x) != _x) || !((vehicle _x) emptyPositions "cargo" == 0))) then {
		
			_rank = rankId _x;
			_target = _x;
			
		};
		
	} forEach ((units group player) - [player]);
	
	if (_rank == -1) exitWith {
	
		_allDead = true;
		player removeAction _id;
		hint "There is no one conscious or alive left";
		
	};
};

if (!_allDead) then {
	
	if ((vehicle _target) != _target) then { //Checks if the target is in a vehicle
	
		if ((vehicle _target) emptyPositions "cargo" == 0) then { //Checks if vehicle has empty seats
		
			hint "No more room in the vehicle, try again later";
			
		} else {
		
			player moveincargo (vehicle _target);
			player removeAction _id;
			
		};
		
	} else {
	
		player setPos (getpos _target);
		player removeAction _id;
		
	};
};
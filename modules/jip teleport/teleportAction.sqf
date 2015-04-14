_id = _this select 2;
_target = _this select 3;

if (!(alive _target) || _target getVariable ["frameworkDead", false] || !((vehicle _target) == _target || (vehicle _target) emptyPositions "cargo" != 0)) then {
	
	_rank = -1;
	_count = 0;

	{
		if ((alive _x) && !(_x getVariable ["frameworkDead", false])) then {
		
			_count = _count + 1;
		
			if (rankId _x > _rank && ((vehicle _x) == _x || (vehicle _x) emptyPositions "cargo" != 0)) then {
		
				_rank = rankId _x;
				_target = _x;
			
			};
		};
		
	} forEach ((units group player) - [player]);
	
	if (_rank == -1) then {
	
		_target = objNull;
		
		if (_count == 0) then {
			
			player removeAction _id;
			cutText ["No one left in the squad", 'PLAIN DOWN'];
			
		} else {
		
			cutText ["Not possible to JIP teleport to anyone, please try again later", 'PLAIN DOWN'];
		
		};
		
	};
};

if (!isNull(_target)) then {
	
	if ((vehicle _target) != _target) then { //Checks if the target is in a vehicle
	
		player moveincargo (vehicle _target);
		player removeAction _id;
	
	} else {
	
		player setPos (getpos _target);
		player removeAction _id;
		
	};
};
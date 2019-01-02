params ["_unit","_vehicle",["_seattype","ANY"],["_seatindex",0]];
	
if (!alive _vehicle) exitwith {diag_log format ["%1 is destroyed! Cannot move %2 into vehicle!",_vehicle,_unit];};
if (!alive _unit) exitwith {diag_log format ["%2 is dead! Cannot move into vehicle %1!",_vehicle,_unit];};

switch (_seattype) do {
	case "driver": {
		_check = _unit moveInAny _vehicle;
		if (!_check) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
	};
	case "driver": {
		if (_vehicle emptyPositions "Driver" == 0) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
		_unit moveindriver _vehicle;
	};
	case "gunner": {
		if (_vehicle emptyPositions "Gunner" == 0) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
		_unit moveingunner _vehicle;
	};
	case "turret": {
		_unit moveinturret [_vehicle,_seatindex];
	};
	case "cargo": {
		if (_vehicle emptyPositions "Cargo" == 0) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
		_unit moveincargo [_vehicle,_seatindex];
	};
	case "commander": {
		if (_vehicle emptyPositions "Commander" == 0) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
		_unit moveInCommander _vehicle;
	};
	default {
		_check = _unit moveInAny _vehicle;
		if (!_check) exitwith {diag_log format ["No empty %1 seats in %2!",_seattype,_vehicle];};
	};
};

true
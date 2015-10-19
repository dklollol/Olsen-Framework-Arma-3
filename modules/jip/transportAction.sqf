_id = _this select 2;
_targets = [];

{

	if ((side player) == (side _x) && (leader _x == _x)) then {

		_targets set [count _targets, _x];

	};

} forEach playableUnits;

[format ["%1 joined the mission and is requesting transport.", name player], "hint", _targets] call BIS_fnc_MP;

player removeAction _id;
_id = _this select 2;
_target = _this select 3;

if (!((_target call FNC_Alive) && (!(_target call FNC_InVehicle) || ((vehicle _target) call FNC_HasEmptyPositions)))) then {

	_rank = -1;
	_count = 0;

	{
		if (_x call FNC_Alive) then {

			_count = _count + 1;

			if ((rankId _x > _rank) && (!(_x call FNC_InVehicle) || ((vehicle _x) call FNC_HasEmptyPositions))) then {

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

	if (_target call FNC_InVehicle) then {

		player moveInAny (vehicle _target);

	} else {

		player setPos (getPos _target);

	};

	player removeAction _id;

};
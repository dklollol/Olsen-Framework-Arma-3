["Ammo Counter", "Counts ammunition types fired and displays it in the mission endscreen.", "TinfoilHate"] call FNC_RegisterModule;

//Ammo Counter Initilization
//Much script by beta, some script by TinfoilHate
//Sets up ammo counting
/*	It's dangerous to go alone, take this:
	_ammoArray = [];
	{
		{
			_ammoClass = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
			if !(_ammoClass in _ammoArray) then {
				_ammoArray set [count _ammoArray,_ammoClass];
			};
		} forEach magazines _x;
	} forEach allMissionObjects "ALL";
	diag_log _ammoArray;
*/

if (isServer) then
{
	aCount_west_ExpendedAmmunition = [];
	aCount_resistance_ExpendedAmmunition = [];
	aCount_east_ExpendedAmmunition = [];

	aCount_classNames = [];
	aCount_getDisplayName =
	{
		private["_className","_displayName","_foundClass","_ret"];
		_className = _this;
		_ret = "Error";
		_foundClass = aCount_classNames find _className;
		if(_foundClass < 0) then
		{
			_cfg = (configFile >> "CfgMagazines" >> _className);
			_ret = 	getText(_cfg >> "displayName");
			aCount_classNames pushBack _className;
			aCount_classNames pushBack _ret;
		}
		else
		{
			_ret = aCount_classNames select( _foundClass + 1);
		};

		_ret
	};

	aCount_addEH =
	{	//If units are spawned, this should be run on them: ["aCount_event_addEH", UNIT] call CBA_fnc_serverEvent;
		_obj = param [0];

		_obj setVariable ["aCount_originalSide",side _obj,false];

		if (_obj isKindOf "Man") then
		{
			_obj addEventHandler ["fired", {[side ( _this select 0),(_this select 5) call aCount_getDisplayName] call aCount_shotCount;}];
			_obj setVariable ["aCount_firedEh", true, false];
		};

		if (((_obj isKindOf "Land") && !(_obj isKindOf "Man")) || (_obj isKindOf "Air") || (_obj isKindOf "Ship")) then
		{
			if (count crew _obj > 0) then
				{
				{
					_x setVariable ["aCount_firedEh", true, false];
					_x setVariable ["aCount_originalSide",side _obj,false];
				} forEach crew _obj;
			};

			_obj addEventHandler ["fired", {[side ( _this select 0),(_this select 5) call aCount_getDisplayName] call aCount_shotCount;}];
			_obj setVariable ["aCount_firedEh", true, false];
		};
	};
	["aCount_event_addEH",aCount_addEH] call CBA_fnc_addEventHandler;

	aCount_shotCount =
	{

		switch (_this select 0) do
		{
			case west:
			{

				_found = aCount_west_ExpendedAmmunition find (_this select 1);
				if(_found < 0) then
				{
					aCount_west_ExpendedAmmunition pushBack (_this select 1) ;
					aCount_west_ExpendedAmmunition pushBack 1;
				}
				else
				{
					aCount_west_ExpendedAmmunition set [_found + 1,(aCount_west_ExpendedAmmunition select _found + 1) + 1 ];
				}

			};

			case east:
			{

				_found = aCount_east_ExpendedAmmunition find (_this select 1);
				if(_found < 0) then
				{

					aCount_east_ExpendedAmmunition pushBack  (_this select 1);
					aCount_east_ExpendedAmmunition pushBack 1;
				}
				else
				{
					aCount_east_ExpendedAmmunition set [_found + 1,(aCount_east_ExpendedAmmunition select _found + 1) + 1 ];
				}
			};
			case resistance:
			{

				_found = aCount_resistance_ExpendedAmmunition find (_this select 1);
				if(_found < 0) then
				{

					aCount_resistance_ExpendedAmmunition pushBack  (_this select 1);
					aCount_resistance_ExpendedAmmunition pushBack 1;
				}
				else
				{
					aCount_resistance_ExpendedAmmunition set [_found + 1,(aCount_resistance_ExpendedAmmunition select _found + 1) + 1 ];
				}
			};
		};
	};

	aCount_endCount =
	{
		_munitionsBLU = aCount_west_ExpendedAmmunition;
		_munitionsRED = aCount_east_ExpendedAmmunition;
		_munitionsRES = aCount_resistance_ExpendedAmmunition;

		["aCount_event_scoreScreen", [_munitionsBLU,_munitionsRED,_munitionsRES]] call CBA_fnc_globalEvent;
	};
};

if (!isDedicated && hasInterface) then
{
	aCount_shotDisplay =
	{
		_this spawn
		{

			_arrayBLU = param [0];
			_arrayRED = param [1];
			_arrayRES = param [2];
			aCount_textBLU = "BLUFOR Munitions Expended:<br/>";
			aCount_textRED = "REDFOR Munitions Expended:<br/>";
			aCount_textRES = "RESISTANCE Munitions Expended:<br/>";
			for [{ _i = 0}, {_i < count _arrayBLU}, {_i = _i + 2}] do
			{
				_label = _arrayBLU select (_i);
				_count = _arrayBLU select (_i + 1);
				aCount_textBLU = aCount_textBLU + _label + ": " + str(_count) + " Rounds" + "<br/>";
			};

			for [{ _i = 0}, {_i < count _arrayRED}, {_i = _i + 2}] do
			{
				_label = _arrayRED select (_i);
				_count = _arrayRED select (_i + 1);
				aCount_textRED = aCount_textRED + _label + ": " + str(_count) + " Rounds" + "<br/>";
			};

			for [{ _i = 0}, {_i < count _arrayRES}, {_i = _i + 2}] do
			{
				_label = _arrayRES select (_i);
				_count = _arrayRES select (_i + 1);
				aCount_textRES = aCount_textRES + _label + ": " + str(_count) + " Rounds" + "<br/>";
			};

		};
	};

	["aCount_event_scoreScreen",aCount_shotDisplay] call CBA_fnc_addEventHandler;
};

["Auto Track Assets", "Automatically runs FNC_TrackAsset on AI vehicles.", "Starfox64"] call FNC_RegisterModule;

if (isServer) then {

	[] spawn {

		private ["_vehicle", "_vehCfg"];

		sleep(1);

		{

			_vehicle = _x;

			if (!isPlayer _vehicle && side _vehicle != civilian) then {

				if (_vehicle getVariable ["FW_AssetName", ""] == "") then {

					{

						if (_x select 1 == side _vehicle) exitWith {

							_vehCfg = (configFile >> "CfgVehicles" >> (typeOf _vehicle));

							if (isText(_vehCfg >> "displayName")) then {

								[_vehicle, getText(_vehCfg >> "displayName"), _x select 0] call FNC_TrackAsset;

							};

						};

					} forEach FW_Teams;

				};

			};

		} forEach vehicles;

	};

};